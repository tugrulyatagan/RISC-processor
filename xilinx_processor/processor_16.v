`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:43:48 05/12/2015 
// Design Name: 
// Module Name:    processor_16 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module processor_16(
		input clock,
		input IRQ,
		input [15:0] processor_input,
		input processor_uart_rx,
		output [15:0] processor_output,
		output processor_uart_tx
	);
	
	wire [15:0] IR;
	wire [11:0] PC;
	
	wire N, Z, C, V;

	wire [2:0] reg_write_adr_d, reg_write_adr_e, reg_write_adr_m, reg_write_adr_w;
	wire reg_write_d, reg_write_e, reg_write_m, reg_write_w;
	
	wire mem_to_reg_d, mem_to_reg_e, mem_to_reg_w;
	wire mem_write_d, mem_write_m;

	wire [2:0] reg_read_adr1_d, reg_read_adr1_e;
	wire [2:0] reg_read_adr2_d, reg_read_adr2_e;
	
	wire [7:0] ALU_con_d, ALU_con_e;
	wire ALU_source2_d, ALU_source2_e;
	wire [15:0] offset_register_d, offset_register_e;

	wire flush_d, flush_e;
	wire stall_d, stall_f;
	wire PC_source;
	
	wire [1:0] forward1_e, forward2_e;

	wire branch_d; 
	wire [3:0] branch_condition_d;
	wire [11:0] ISR_adr;
	wire branch_ISR;
	
	wire subroutine_call_d;
	wire subroutine_return_d; 
	wire [11:0] RTS_adr;
	
	wire IEN_d, IOF_d, RTI_d;

	organisation organisation_unit (
		.clock(clock), 
		.reg_read_adr1(reg_read_adr1_d), 
		.reg_read_adr2(reg_read_adr2_d), 
		.reg_write_adr(reg_write_adr_w), 
		.reg_write(reg_write_w), 
		.flush_e(flush_e), 
		.forward1(forward1_e), 
		.forward2(forward2_e), 
		.ALU_con(ALU_con_e), 
		.ALU_source2(ALU_source2_e), 
		.offset(offset_register_e), 
		.mem_write(mem_write_m), 
		.mem_to_reg(mem_to_reg_w),
		.processor_input(processor_input),
		.processor_uart_rx(processor_uart_rx),
		// Outputs
		.N(N), 
		.Z(Z), 
		.C(C), 
		.V(V),
		.processor_output(processor_output),
		.processor_uart_tx(processor_uart_tx),
		.internal_IRQ(internal_IRQ)
	);
	
	IR_fetch fetch_unit (
		.clock(clock), 
		.PC_source(PC_source), 
		.PC_offset(offset_register_d[11:0]), 
		.ISR_adr(ISR_adr), 
		.branch_ISR(branch_ISR), 
		.stall_d(stall_d), 
		.stall_f(stall_f), 
		.flush_d(flush_d), 
		// Outputs
		.IR(IR), 
		.PC(PC)
	);
	
	decode_unit decode_unit (
		.IR(IR), 
		.PC(PC),
		.RTS_adr(RTS_adr),				/////////////////
		// Outputs
		.reg_read_adr1_d(reg_read_adr1_d), 
		.reg_read_adr2_d(reg_read_adr2_d), 
		.reg_write_adr_d(reg_write_adr_d), 
		.reg_write_d(reg_write_d), 
		.ALU_source2_d(ALU_source2_d), 
		.ALU_con_d(ALU_con_d), 
		.offset_register_d(offset_register_d), 
		.mem_write_d(mem_write_d), 
		.mem_to_reg_d(mem_to_reg_d), 
		.branch_d(branch_d), 
		.branch_condition_d(branch_condition_d), 
		.subroutine_call_d(subroutine_call_d),  /////////////////////////////
		.subroutine_return_d(subroutine_return_d), ///////////////
		.IEN_d(IEN_d),
		.IOF_d(IOF_d),
		.RTI_d(RTI_d)
	);
	
	branch branch_control_unit (
		.branch_d(branch_d), 
		.branch_condition_d(branch_condition_d), 
		.Z(Z), 
		.N(N), 
		.V(V), 
		.C(C), 
		// Outputs
		.PC_source(PC_source)
	);

	subroutine_stack sub_stack (
		.clock(clock), 
		.subroutine_call(subroutine_call_d), 
		.subroutine_return(subroutine_return_d), 
		.PC(PC), 
		// Outputs
		.RTS_adr(RTS_adr)
	);

	hazard hazard_detection_unit (
		.reg_read_adr1_d(reg_read_adr1_d), 
		.reg_read_adr2_d(reg_read_adr2_d), 
		.reg_read_adr1_e(reg_read_adr1_e), 
		.reg_read_adr2_e(reg_read_adr2_e), 
		.reg_write_adr_e(reg_write_adr_e), 
		.mem_to_reg_e(mem_to_reg_e), 
		.reg_write_m(reg_write_m), 
		.reg_write_adr_m(reg_write_adr_m), 
		.reg_write_w(reg_write_w), 
		.reg_write_adr_w(reg_write_adr_w), 
		.PC_source(PC_source), 
		// Outputs
		.stall_f(stall_f), 
		.stall_d(stall_d), 
		.flush_d(flush_d), 
		.flush_e(flush_e), 
		.forward1_e(forward1_e), 
		.forward2_e(forward2_e)
	);
	
	interrupt interrupt_control_unit (
		.clock(clock), 
		.IEN_d(IEN_d), 
		.IOF_d(IOF_d), 
		.RTI_d(RTI_d), 
		.branch_d(branch_d), 
		.IRQ(IRQ), 
		.PC(PC), 
		// Outputs
		.branch_ISR(branch_ISR), 
		.ISR_adr(ISR_adr)
	);
	
	pipeline_control_registers pipeline_registers (
		.clock(clock), 
		.flush_e(flush_e), 
		.reg_write_d(reg_write_d), 
		.reg_write_adr_d(reg_write_adr_d), 
		.mem_to_reg_d(mem_to_reg_d), 
		.mem_write_d(mem_write_d), 
		.ALU_con_d(ALU_con_d), 
		.ALU_source2_d(ALU_source2_d), 
		.offset_register_d(offset_register_d),
		.reg_read_adr1_d(reg_read_adr1_d), 
		.reg_read_adr2_d(reg_read_adr2_d), 
		// Outputs
		.reg_write_e(reg_write_e), 
		.reg_write_adr_e(reg_write_adr_e), 
		.mem_to_reg_e(mem_to_reg_e), 
		.mem_write_e(), /////////////////////////////////
		.ALU_con_e(ALU_con_e), 
		.ALU_source2_e(ALU_source2_e), 
		.offset_register_e(offset_register_e), 
		.reg_read_adr1_e(reg_read_adr1_e), 
		.reg_read_adr2_e(reg_read_adr2_e), 
		.reg_write_m(reg_write_m), 
		.reg_write_adr_m(reg_write_adr_m), 
		.mem_to_reg_m(mem_to_reg_m), 
		.mem_write_m(mem_write_m), 
		.reg_write_w(reg_write_w), 
		.reg_write_adr_w(reg_write_adr_w), 
		.mem_to_reg_w(mem_to_reg_w)
	);

endmodule
