`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:40:24 05/08/2015
// Design Name:   IR_fetch
// Module Name:   /media/BELGELER/Workspaces/Xilinx/processor/test_fetch.v
// Project Name:  processor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: IR_fetch
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_fetch;

	// Inputs
	reg clock;
	reg PC_source;
	reg [11:0] PC_offset;
	reg [11:0] ISR_adr;
	reg branch_ISR;
	reg stall_d;
	reg stall_f;
	reg flush_d;

	// Outputs
	wire [15:0] IR;
	wire [11:0] PC;

	// Instantiate the Unit Under Test (UUT)
	IR_fetch uut (
		.clock(clock), 
		.PC_source(PC_source), 
		.PC_offset(PC_offset), 
		.ISR_adr(ISR_adr), 
		.branch_ISR(branch_ISR), 
		.stall_d(stall_d), 
		.stall_f(stall_f), 
		.flush_d(flush_d), 
		.IR(IR), 
		.PC(PC)
	);

	initial begin
		// Initialize Inputs
		clock = 0;
		PC_source = 0;
		PC_offset = 0;
		ISR_adr = 0;
		branch_ISR = 0;
		stall_f = 0;
		stall_d = 0;
		flush_d = 0;

		// Wait 100 ns for global reset to finish
		//#100;
		#10;
		
		#400;
		flush_d = 1;
		
		#20;
		flush_d = 0;
		
		
		
		  
	end
	
	always #10 clock = !clock;
      
endmodule

