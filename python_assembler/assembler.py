#!/usr/bin/python
# -*- coding: utf8 -*-
import sys
import os
import re
import yaml
import subprocess
import platform

variableDict = {}

def main(conf):
    if not os.path.isfile(conf['assembly_input_file']):
        sys.exit(["Assembly input file does not exist", conf['assembly_input_file']])
    input_file = open(conf['assembly_input_file'], 'r')
    lines = input_file.readlines()
    input_file.close()

    # remove comments
    remove_comments = [line.split(';')[0] for line in lines]

    data = ''
    mnemonic = ''
    if '_initial\n' in remove_comments:
        data = remove_comments[remove_comments.index('_initial\n') + 1:remove_comments.index('_end\n')]
        mnemonic = remove_comments[remove_comments.index('_end\n') + 1:]
    else:
        mnemonic = remove_comments

    divided_data = filter(None, [filter(None, re.split('\t|\n|,| ', line)) for line in data])

    data_map = []
    for line in divided_data:
        if line[0][0] == '$':
            variableDict[line[0]] = int(line[2])
        else:
            data_map.append([line[0], map(int, line[2:])])

    # calculate data address
    i = 0
    for line in data_map:
        line.extend([i])
        variableDict['&' + line[0]] = i
        i += len(line[1])

    # divide mnemonic
    divided_mnemonic = filter(None, [filter(None, re.split('\t|\n|,| ', line)) for line in mnemonic])

    mnemonic_map = []
    for line in divided_mnemonic:
        if ':' == line[0][-1]:
            mnemonic_map.append([line[1:], line[0][:-1]])
        else:
            mnemonic_map.append([line, None])

    # Find addresses
    for i, mnemonic in enumerate(mnemonic_map):
        mnemonic.extend([i])
    # find ISR address
    isr_address = 0
    isr = [k for k, l in enumerate(mnemonic_map) if 'ISR' in l]
    if isr:
        isr_address = isr[0]

    # calculate branch offsets and replace variables
    for i, mnemonic in enumerate(mnemonic_map):
        if mnemonic[0][0][0] == 'B':
            # find label
            label_index = [k for k, l in enumerate(mnemonic_map) if mnemonic[0][1] in l][0]
            # calculate offset
            offset = label_index - i - 1
            mnemonic.extend([offset])
        else:
            mnemonic.extend([None])

        if any('$' in string for string in mnemonic[0]):
            variable_index = [i for i, s in enumerate(mnemonic[0]) if '$' in s][0]
            if mnemonic[0][variable_index][-1] == ']':
                mnemonic[0][variable_index] = '#' + str(variableDict[mnemonic[0][variable_index][:-1]]) + ']'
            else:
                mnemonic[0][variable_index] = '#' + str(variableDict[mnemonic[0][variable_index]])

        if any('&' in string for string in mnemonic[0]):
            variable_index = [i for i, s in enumerate(mnemonic[0]) if '&' in s][0]
            if mnemonic[0][variable_index][-1] == ']':
                mnemonic[0][variable_index] = '#' + str(variableDict[mnemonic[0][variable_index][:-1]]) + ']'
            else:
                mnemonic[0][variable_index] = '#' + str(variableDict[mnemonic[0][variable_index]])

    # calculate hex
    for mnemonic in mnemonic_map:
        mnemonic_to_opcode(mnemonic)

    # Print
    # print variableDict
    print conf['assembly_input_file']
    for instruction in mnemonic_map:
        print "{0:0>3X}".format(instruction[2]+16), ' ', instruction[4], bin_to_hex(instruction[4]), '   ',  " ".join(instruction[0])
        # print instruction, bin_to_hex(instruction[4])

    # Create FPGA simulation binary file
    if set(['fpga_simulation_rom_output_file', 'fpga_simulation_ram_output_file']).issubset(conf):
        # ROM
        rom_file = open(conf['fpga_simulation_rom_output_file'], 'w')
        rom_file.write(hex_to_bin('E00F', 16) + '\n')
        rom_file.write(hex_to_bin('E' + "{0:0>3X}".format(isr_address+14), 16) + '\n')
        for i in range(14):
            rom_file.write(hex_to_bin('0000', 16) + '\n')
        for instruction in mnemonic_map:
            rom_file.write(instruction[4] + '\n')
        rom_file.close()

        # RAM
        ram_file = open(conf['fpga_simulation_ram_output_file'], 'w')
        for line in data_map:
            for item in line[1]:
                ram_file.write(hex_to_bin(decimal_to_hex(item), 16) + '\n')
        ram_file.close()

    # Create Logisim hex file
    if set(['logisim_rom_output_file', 'logisim_ram_output_file']).issubset(conf):
        # ROM
        rom_file = open(conf['logisim_rom_output_file'], 'w')
        rom_file.write('v2.0 raw\n')
        rom_file.write('E00F\n')
        rom_file.write('E' + "{0:0>3X}".format(isr_address+14) + '\n')
        for i in range(14):
            rom_file.write('0000\n')
        for instruction in mnemonic_map:
            rom_file.write(bin_to_hex(instruction[4]) + '\n')
        rom_file.close()

        # RAM
        ram_file = open(conf['logisim_ram_output_file'], 'w')
        ram_file.write('v2.0 raw\n')
        for line in data_map:
            for item in line[1]:
                ram_file.write(decimal_to_hex(item) + '\n')
        ram_file.close()

    if set(['xilinx_data2mem_path', 'fpga_rom_bmm_input_file', 'fpga_ram_bmm_input_file', 'fpga_top_module_bit_input_file', 'fpga_modified_bit_output_file']).issubset(conf):
        # Create mem files
        # ROM
        rom_mem_file = open('rom.mem', 'w')
        rom_mem_file.write('@0000 E00F ')
        rom_mem_file.write('E' + "{0:0>3X}".format(isr_address+14) + ' ')
        for i in range(14):
            rom_mem_file.write('0000 ')
        for instruction in mnemonic_map:
            rom_mem_file.write(bin_to_hex(instruction[4]) + ' ')
        rom_mem_file.close()

        # RAM
        ram_mem_file = open('ram.mem', 'w')
        ram_mem_file.write('@0000 ')
        for line in data_map:
            for item in line[1]:
                ram_mem_file.write(decimal_to_hex(item) + ' ')
        ram_mem_file.close()

        # read memory tags
        if not os.path.isfile(conf['fpga_rom_bmm_input_file']):
            sys.exit(["ROM memory bmm file does not exist", conf['fpga_rom_bmm_input_file']])
        rom_bmm_file = open(conf['fpga_rom_bmm_input_file'], 'r')
        rom_bmm_line = rom_bmm_file.readline()
        rom_memory_tag = rom_bmm_line.split()[1]
        rom_bmm_file.close()

        if not os.path.isfile(conf['fpga_ram_bmm_input_file']):
            sys.exit(["RAM memory bmm file does not exist", conf['fpga_ram_bmm_input_file']])
        ram_bmm_file = open(conf['fpga_ram_bmm_input_file'], 'r')
        ram_bmm_line = ram_bmm_file.readline()
        ram_memory_tag = ram_bmm_line.split()[1]
        ram_bmm_file.close()

        # Call data2mem
        if not os.path.isfile(conf['fpga_top_module_bit_input_file']):
            sys.exit(["FPGA top module bit file does not exist", conf['fpga_top_module_bit_input_file']])
        subprocess.call([conf['xilinx_data2mem_path'], '-bm', conf['fpga_rom_bmm_input_file'], '-bt', conf['fpga_top_module_bit_input_file'], '-bd', 'rom.mem', 'tag', rom_memory_tag, '-o', 'b', '_temp.bit'])
        subprocess.call([conf['xilinx_data2mem_path'], '-bm', conf['fpga_ram_bmm_input_file'], '-bt', '_temp.bit', '-bd', 'ram.mem', 'tag', ram_memory_tag, '-o', 'b', conf['fpga_modified_bit_output_file']])

        # remove temp files
        if os.path.isfile('_temp.bit'):
            os.remove('_temp.bit')
        os.remove('rom.mem')
        os.remove('ram.mem')

        print 'New bit file', conf['fpga_modified_bit_output_file'], 'created'

    # Program FPGA
    if 'xilinx_impact_path' in conf:
        impact_cmd_file = open('impact.cmd', 'w')
        impact_cmd_file.write('setmode -bscan\nsetCable -p auto\nidentify\nassignfile -p 1 -file ')
        impact_cmd_file.write(conf['fpga_modified_bit_output_file'])
        impact_cmd_file.write('\nprogram -p 1\nquit')
        impact_cmd_file.close()

        if not os.path.isfile(conf['xilinx_impact_path']):
            sys.exit(["Xilinx impact does not exist", conf['xilinx_impact_path']])
        if platform.system() == 'Linux':
            if os.geteuid() == 0:
                subprocess.call([conf['xilinx_impact_path'], '-batch', 'impact.cmd'])
            else:
                print "Impact must grant root access on Linux"
        elif platform.system() == 'Windows':
            subprocess.call([conf['xilinx_impact_path'], '-batch', 'impact.cmd'])

        if os.path.isfile('_impactbatch.log'):
            os.remove('_impactbatch.log')
        if os.path.isfile('impact.cmd'):
            os.remove('impact.cmd')


def mnemonic_to_opcode(mnemonic):
    opcode = ""

    # 1. Inherent
    if mnemonic[0][0] == 'NOP':
        opcode = hex_to_bin('0000', 16)
    elif mnemonic[0][0] == 'ION':
        opcode = hex_to_bin('0001', 16)
    elif mnemonic[0][0] == 'IOF':
        opcode = hex_to_bin('0002', 16)
    elif mnemonic[0][0] == 'RTI':
        opcode = hex_to_bin('0003', 16)
    elif mnemonic[0][0] == 'RTS':
        opcode = hex_to_bin('0004', 16)

    # 2. Shift
    elif (mnemonic[0][0] == 'LSL') and (mnemonic[0][3][0] == '#'):
        opcode = '0001' + '00' + decimal_to_bin(mnemonic[0][3][1:], 4) + decimal_to_bin(mnemonic[0][2][1:], 3) + decimal_to_bin(mnemonic[0][1][1:], 3)
    elif (mnemonic[0][0] == 'LSR') and (mnemonic[0][3][0] == '#'):
        opcode = '0001' + '01' + decimal_to_bin(mnemonic[0][3][1:], 4) + decimal_to_bin(mnemonic[0][2][1:], 3) + decimal_to_bin(mnemonic[0][1][1:], 3)
    elif (mnemonic[0][0] == 'ASR') and (mnemonic[0][3][0] == '#'):
        opcode = '0001' + '10' + decimal_to_bin(mnemonic[0][3][1:], 4) + decimal_to_bin(mnemonic[0][2][1:], 3) + decimal_to_bin(mnemonic[0][1][1:], 3)
    elif (mnemonic[0][0] == 'CSL') and (mnemonic[0][3][0] == '#'):
        opcode = '0001' + '11' + decimal_to_bin(mnemonic[0][3][1:], 4) + decimal_to_bin(mnemonic[0][2][1:], 3) + decimal_to_bin(mnemonic[0][1][1:], 3)

    # 4. Move/Compare/Add/Subtract Immediate
    elif (mnemonic[0][0] == 'MOV') and (mnemonic[0][2][0] == '#'):
        opcode = '010' + '00' + decimal_to_bin(mnemonic[0][1][1:], 3) + decimal_to_bin(mnemonic[0][2][1:], 8)
    elif (mnemonic[0][0] == 'CMP') and (mnemonic[0][2][0] == '#'):
        opcode = '010' + '01' + decimal_to_bin(mnemonic[0][1][1:], 3) + decimal_to_bin(mnemonic[0][2][1:], 8)
    elif (mnemonic[0][0] == 'ADD') and (mnemonic[0][2][0] == '#'):
        opcode = '010' + '10' + decimal_to_bin(mnemonic[0][1][1:], 3) + decimal_to_bin(mnemonic[0][2][1:], 8)
    elif (mnemonic[0][0] == 'SUB') and (mnemonic[0][2][0] == '#'):
        opcode = '010' + '11' + decimal_to_bin(mnemonic[0][1][1:], 3) + decimal_to_bin(mnemonic[0][2][1:], 8)

    elif mnemonic[0][0] == 'MOV':
        opcode = '0010000000' + decimal_to_bin(mnemonic[0][2][1:], 3) + decimal_to_bin(mnemonic[0][1][1:], 3)

    # 3. Add/Subtract Register Immediate
    elif (mnemonic[0][0] == 'ADD') and (mnemonic[0][3][0] == '#'):
        opcode = '001' + '0' + decimal_to_bin(mnemonic[0][3][1:], 6) + decimal_to_bin(mnemonic[0][2][1:], 3) + decimal_to_bin(mnemonic[0][1][1:], 3)
    elif (mnemonic[0][0] == 'SUB') and (mnemonic[0][3][0] == '#'):
        opcode = '001' + '1' + decimal_to_bin(mnemonic[0][3][1:], 6) + decimal_to_bin(mnemonic[0][2][1:], 3) + decimal_to_bin(mnemonic[0][1][1:], 3)

    # 5. ALU
    elif mnemonic[0][0] == 'AND':
        opcode = '011' + '0000' + decimal_to_bin(mnemonic[0][3][1:], 3) + decimal_to_bin(mnemonic[0][2][1:], 3) + decimal_to_bin(mnemonic[0][1][1:], 3)
    elif mnemonic[0][0] == 'OR':
        opcode = '011' + '0001' + decimal_to_bin(mnemonic[0][3][1:], 3) + decimal_to_bin(mnemonic[0][2][1:], 3) + decimal_to_bin(mnemonic[0][1][1:], 3)
    elif mnemonic[0][0] == 'XOR':
        opcode = '011' + '0010' + decimal_to_bin(mnemonic[0][3][1:], 3) + decimal_to_bin(mnemonic[0][2][1:], 3) + decimal_to_bin(mnemonic[0][1][1:], 3)
    elif mnemonic[0][0] == 'LSL':
        opcode = '011' + '0011' + decimal_to_bin(mnemonic[0][3][1:], 3) + decimal_to_bin(mnemonic[0][2][1:], 3) + decimal_to_bin(mnemonic[0][1][1:], 3)
    elif mnemonic[0][0] == 'LSR':
        opcode = '011' + '0100' + decimal_to_bin(mnemonic[0][3][1:], 3) + decimal_to_bin(mnemonic[0][2][1:], 3) + decimal_to_bin(mnemonic[0][1][1:], 3)
    elif mnemonic[0][0] == 'ASR':
        opcode = '011' + '0101' + decimal_to_bin(mnemonic[0][3][1:], 3) + decimal_to_bin(mnemonic[0][2][1:], 3) + decimal_to_bin(mnemonic[0][1][1:], 3)
    elif mnemonic[0][0] == 'CSL':
        opcode = '011' + '0110' + decimal_to_bin(mnemonic[0][3][1:], 3) + decimal_to_bin(mnemonic[0][2][1:], 3) + decimal_to_bin(mnemonic[0][1][1:], 3)
    elif mnemonic[0][0] == 'ADD':
        opcode = '011' + '0111' + decimal_to_bin(mnemonic[0][3][1:], 3) + decimal_to_bin(mnemonic[0][2][1:], 3) + decimal_to_bin(mnemonic[0][1][1:], 3)
    elif mnemonic[0][0] == 'SUB':
        opcode = '011' + '1000' + decimal_to_bin(mnemonic[0][3][1:], 3) + decimal_to_bin(mnemonic[0][2][1:], 3) + decimal_to_bin(mnemonic[0][1][1:], 3)
    elif mnemonic[0][0] == 'NEG':
        opcode = '011' + '1001' + '000' + decimal_to_bin(mnemonic[0][2][1:], 3) + decimal_to_bin(mnemonic[0][1][1:], 3)
    elif mnemonic[0][0] == 'NOT':
        opcode = '011' + '1010' + '000' + decimal_to_bin(mnemonic[0][2][1:], 3) + decimal_to_bin(mnemonic[0][1][1:], 3)
    elif mnemonic[0][0] == 'CMP':
        opcode = '011' + '1011' + decimal_to_bin(mnemonic[0][2][1:], 3) + decimal_to_bin(mnemonic[0][1][1:], 3) + '000'
    elif mnemonic[0][0] == 'TST':
        opcode = '011' + '1100' + decimal_to_bin(mnemonic[0][2][1:], 3) + decimal_to_bin(mnemonic[0][1][1:], 3) + '000'
    elif mnemonic[0][0] == 'MUL':
        opcode = '011' + '1101' + decimal_to_bin(mnemonic[0][3][1:], 3) + decimal_to_bin(mnemonic[0][2][1:], 3) + decimal_to_bin(mnemonic[0][1][1:], 3)


    # 7. Load/Store with Immediate Offset
    # LD
    elif (mnemonic[0][0] == 'LD') and (len(mnemonic[0])) == 3:
        opcode = '101' + '0' + '000000' + decimal_to_bin(mnemonic[0][2][2], 3) + decimal_to_bin(mnemonic[0][1][1], 3)
    elif (mnemonic[0][0] == 'LD') and (mnemonic[0][3][0]) == '#':
        opcode = '101' + '0' + decimal_to_bin(mnemonic[0][3][1:-1], 6) + decimal_to_bin(mnemonic[0][2][2], 3) + decimal_to_bin(mnemonic[0][1][1], 3)
    # STR
    elif (mnemonic[0][0] == 'STR') and (len(mnemonic[0])) == 3:
        opcode = '101' + '1' + '000000' + decimal_to_bin(mnemonic[0][1][2], 3) + decimal_to_bin(mnemonic[0][2][1], 3)
    elif (mnemonic[0][0] == 'STR') and (mnemonic[0][2][0]) == '#':
        opcode = '101' + '1' + decimal_to_bin(mnemonic[0][2][1:-1], 6) + decimal_to_bin(mnemonic[0][1][2], 3) + decimal_to_bin(mnemonic[0][3][1], 3)

    # 6. Load/Store with Register Offset
    elif mnemonic[0][0] == 'LD':
        opcode = '100' + '000' + '0' + decimal_to_bin(mnemonic[0][3][1], 3) + decimal_to_bin(mnemonic[0][2][2], 3) + decimal_to_bin(mnemonic[0][1][1], 3)

    # 8. Conditional Branch
    elif mnemonic[0][0] == 'BEQ':
        opcode = '110' + '0000' + signed_decimal_to_bin(mnemonic[3], 9)
    elif mnemonic[0][0] == 'BNE':
        opcode = '110' + '0001' + signed_decimal_to_bin(mnemonic[3], 9)
    elif mnemonic[0][0] == 'BCS':
        opcode = '110' + '0010' + signed_decimal_to_bin(mnemonic[3], 9)
    elif mnemonic[0][0] == 'BCC':
        opcode = '110' + '0011' + signed_decimal_to_bin(mnemonic[3], 9)
    elif mnemonic[0][0] == 'BMI':
        opcode = '110' + '0100' + signed_decimal_to_bin(mnemonic[3], 9)
    elif mnemonic[0][0] == 'BPL':
        opcode = '110' + '0101' + signed_decimal_to_bin(mnemonic[3], 9)
    elif mnemonic[0][0] == 'BVS':
        opcode = '110' + '0110' + signed_decimal_to_bin(mnemonic[3], 9)
    elif mnemonic[0][0] == 'BVC':
        opcode = '110' + '0111' + signed_decimal_to_bin(mnemonic[3], 9)
    elif mnemonic[0][0] == 'BHI':
        opcode = '110' + '1000' + signed_decimal_to_bin(mnemonic[3], 9)
    elif mnemonic[0][0] == 'BLS':
        opcode = '110' + '1001' + signed_decimal_to_bin(mnemonic[3], 9)
    elif mnemonic[0][0] == 'BGE':
        opcode = '110' + '1010' + signed_decimal_to_bin(mnemonic[3], 9)
    elif mnemonic[0][0] == 'BLT':
        opcode = '110' + '1011' + signed_decimal_to_bin(mnemonic[3], 9)
    elif mnemonic[0][0] == 'BGT':
        opcode = '110' + '1100' + signed_decimal_to_bin(mnemonic[3], 9)
    elif mnemonic[0][0] == 'BLE':
        opcode = '110' + '1101' + signed_decimal_to_bin(mnemonic[3], 9)

    # 9. Unconditional Branch
    elif mnemonic[0][0] == 'BAL':
        opcode = '11100' + signed_decimal_to_bin(mnemonic[3], 11)

    # 10. Branch to Subroutine
    elif mnemonic[0][0] == 'BTS':
        opcode = '11101' + signed_decimal_to_bin(mnemonic[3], 11)

    # 11. Move Long Immediate
    elif mnemonic[0][0] == 'MOVL':
        opcode = '1111' + decimal_to_bin(mnemonic[0][2][1:], 12)

    else:
        raise Exception('Opcode could not find', mnemonic[0])

    mnemonic.extend([opcode])


def hex_to_bin(hex_string, bit):
    return bin(int(hex_string, 16))[2:].zfill(bit)


def decimal_to_bin(decimal_string, bit):
    if int(decimal_string, 10) >= 2**bit:
        raise Exception('Number is too big', decimal_string, bit)
    return bin(int(decimal_string, 10))[2:].zfill(bit)


def signed_decimal_to_bin(decimal, bit):
    if decimal >= 2**bit:
        raise Exception('Number is too big', decimal, bit)

    if decimal < 0:
        return bin(2**bit + decimal)[2:].zfill(bit)
    else:
        return bin(decimal)[2:].zfill(bit)


def bin_to_hex(bin_string):
    return "{0:0>4X}".format(int(bin_string, 2))


def decimal_to_hex(decimal):
    return "{0:0>4X}".format(decimal)


if __name__ == "__main__":
    if len(sys.argv) == 2:
        if not os.path.isfile(sys.argv[1]):
            sys.exit(["Configuration file does not exist", sys.argv[1]])
        conf_file = open(sys.argv[1], 'r')
        parameters = yaml.load(conf_file)
        if 'assembly_input_file' not in parameters:
            sys.exit(["Assembly input file is not specified in conf file", parameters])
        main(parameters)
    else:
        print sys.argv, len(sys.argv)
        sys.exit("Missing parameters! Please give only conf file location")
