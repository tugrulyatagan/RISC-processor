`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:59:53 05/17/2015
// Design Name:   Atlys_Spartan6
// Module Name:   E:/Workspaces/Xilinx/processor/test_fpga.v
// Project Name:  processor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Atlys_Spartan6
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_fpga;

	// Inputs
	reg clk;

	// Outputs
	wire [7:0] Led;

	// Instantiate the Unit Under Test (UUT)
	Atlys_Spartan6 uut (
		.clk(clk), 
		.Led(Led)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		
		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
	
	always #10 clk = !clk;
      
endmodule

