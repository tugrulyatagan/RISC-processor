`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:22:46 05/08/2015
// Design Name:   branch
// Module Name:   /media/BELGELER/Workspaces/Xilinx/processor/test_branch.v
// Project Name:  processor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: branch
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_branch;

	// Inputs
	reg branch_d;
	reg [3:0] branch_condition_d;
	reg Z;
	reg N;
	reg V;
	reg C;

	// Outputs
	wire PC_source;

	// Instantiate the Unit Under Test (UUT)
	branch uut (
		.branch_d(branch_d), 
		.branch_condition_d(branch_condition_d), 
		.Z(Z), 
		.N(N), 
		.V(V), 
		.C(C), 
		.PC_source(PC_source)
	);

	initial begin
		// Initialize Inputs
		branch_d = 0;
		branch_condition_d = 0;
		Z = 0;
		N = 0;
		V = 0;
		C = 0;

		// Wait 100 ns for global reset to finish
		//#100;
        
		#1;
		branch_condition_d = 4'h1;
		branch_d = 1;
		
		#1;
		branch_condition_d = 4'h2;
		
		#1;
		branch_condition_d = 4'h3;
		
		#1;
		C = 1;
		branch_condition_d = 4'h8;
		
		#1;
		branch_condition_d = 4'ha;
		
		#1;
		V = 1;

		
		

		
		  
		// Add stimulus here

	end
      
endmodule

