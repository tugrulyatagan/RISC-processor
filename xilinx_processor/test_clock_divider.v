`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:42:39 05/17/2015
// Design Name:   clock_divider
// Module Name:   E:/Workspaces/Xilinx/processor/test_clock_divider.v
// Project Name:  processor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: clock_divider
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_clock_divider;

	// Inputs
	reg in_clk;
	reg [31:0] divider_factor;

	// Outputs
	wire out_clk;

	// Instantiate the Unit Under Test (UUT)
	clock_divider uut (
		.in_clk(in_clk), 
		.divider_factor(divider_factor),
		.out_clk(out_clk)
	);

	initial begin
		// Initialize Inputs
		in_clk = 0;
		divider_factor = 0;

		#200;  
		divider_factor = 1;
		
		#300;  
		divider_factor = 2;

	end
	
	always #10 in_clk = !in_clk;  
endmodule

