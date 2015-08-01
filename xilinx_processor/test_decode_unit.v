`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   00:36:02 05/25/2015
// Design Name:   decode_unit
// Module Name:   E:/Workspaces/Xilinx/processor/test_decode_unit.v
// Project Name:  processor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: decode_unit
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_decode_unit;

	// Inputs
	reg [15:0] IR;
	reg [11:0] PC;
	reg [11:0] RTS_adr;

	// Outputs
	wire [2:0] reg_read_adr1_d;
	wire [2:0] reg_read_adr2_d;
	wire [2:0] reg_write_adr_d;
	wire reg_write_d;
	wire ALU_source2_d;
	wire [7:0] ALU_con_d;
	wire [15:0] offset_register_d;
	wire mem_write_d;
	wire mem_to_reg_d;
	wire branch_d;
	wire [3:0] branch_condition_d;
	wire subroutine_call_d;
	wire subroutine_return_d;
	wire IEN_d;
	wire IOF_d;
	wire RTI_d;

	// Instantiate the Unit Under Test (UUT)
	decode_unit uut (
		.IR(IR), 
		.PC(PC), 
		.RTS_adr(RTS_adr), 
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
		.subroutine_call_d(subroutine_call_d), 
		.subroutine_return_d(subroutine_return_d), 
		.IEN_d(IEN_d), 
		.IOF_d(IOF_d), 
		.RTI_d(RTI_d)
	);

	initial begin
		// Initialize Inputs
		IR = 0;
		PC = 20;
		RTS_adr = 15;

		// Wait 100 ns for global reset to finish
        
		#10;
		IR = 16'h6e89;
		
		#10;
		IR = 16'he802;
		
		#10;
		IR = 16'h0004;

	end
      
endmodule

