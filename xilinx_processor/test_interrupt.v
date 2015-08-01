`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   02:15:59 05/09/2015
// Design Name:   interrupt
// Module Name:   /media/BELGELER/Workspaces/Xilinx/processor/test_interrupt.v
// Project Name:  processor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: interrupt
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_interrupt;

	// Inputs
	reg clock;
	reg IEN_d;
	reg IOF_d;
	reg RTI_d;
	reg branch_d;
	reg IRQ;
	reg [11:0] PC;

	// Outputs
	wire branch_ISR;
	wire [11:0] ISR_adr;

	// Instantiate the Unit Under Test (UUT)
	interrupt uut (
		.clock(clock), 
		.IEN_d(IEN_d), 
		.IOF_d(IOF_d), 
		.RTI_d(RTI_d), 
		.branch_d(branch_d), 
		.IRQ(IRQ), 
		.PC(PC), 
		.branch_ISR(branch_ISR), 
		.ISR_adr(ISR_adr)
	);

	initial begin
		// Initialize Inputs
		clock = 0;
		IEN_d = 0;
		IOF_d = 0;
		RTI_d = 0;
		branch_d = 0;
		IRQ = 0;
		PC = 35;

		// Wait 100 ns for global reset to finish
		//#100;
        
		#1;
		IEN_d = 1;
		
		#1;
		IEN_d = 0;
		
		#5;
		
		IRQ = 1;
		
		

	end
	
	always #1 clock = !clock;

endmodule

