`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:48:40 05/03/2015
// Design Name:   control_unit
// Module Name:   /media/BELGELER/Workspaces/Xilinx/processor/test_control_with_fetch.v
// Project Name:  processor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: control_unit
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_control_with_fetch;

	// Inputs
	wire [15:0] IR;

	//wire [15:0] IRR;
	
	reg clock;
	reg PC_source;
	reg [11:0] PC_offset;

	// Outputs
	wire [2:0] reg_read_adr1;
	wire [2:0] reg_read_adr2;
	wire [2:0] reg_write_adr_d;
	wire reg_write_d;
	wire ALU_source2_d;
	wire [7:0] ALU_con_d;
	wire [15:0] offset_register;
	wire mem_write_d;
	wire mem_to_reg_d;
	wire branch_d;
	wire [3:0] branch_condition_d;
	wire IEN;

	// Instantiate the Unit Under Test (UUT)
	control_unit uut (
		.IR(IR), 
		.reg_read_adr1(reg_read_adr1), 
		.reg_read_adr2(reg_read_adr2), 
		.reg_write_adr_d(reg_write_adr_d), 
		.reg_write_d(reg_write_d), 
		.ALU_source2_d(ALU_source2_d), 
		.ALU_con_d(ALU_con_d), 
		.offset_register(offset_register), 
		.mem_write_d(mem_write_d), 
		.mem_to_reg_d(mem_to_reg_d), 
		.branch_d(branch_d), 
		.branch_condition_d(branch_condition_d), 
		.IEN(IEN)
	);


	IR_fetch uutfetch (
		.clock(clock), 
		.PC_source(PC_source), 
		.PC_offset(PC_offset), 
		.IR(IR)
	);

	initial begin
		// Initialize Inputs
		clock = 0;
		PC_source = 0;
		PC_offset = 0;

		// Wait 100 ns for global reset to finish
		//#100;
        
		// Add stimulus here

	end
	
	always #1 clock = !clock;
endmodule

