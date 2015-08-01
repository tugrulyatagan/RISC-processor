`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:23:35 04/24/2015
// Design Name:   ADD
// Module Name:   /media/BELGELER/Workspaces/Xilinx/processor/test_add.v
// Project Name:  processor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ADD
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_add;

	// Inputs
	reg [15:0] a;
	reg [15:0] b;

	// Outputs
	wire [15:0] sum;
	wire overflow;
	wire carry;

	// Instantiate the Unit Under Test (UUT)
	ADD uut (
		.a(a), 
		.b(b), 
		.sum(sum), 
		.overflow(overflow), 
		.carry(carry)
	);

	initial begin
		// Initialize Inputs
		a = 0;
		b = 0;

		// Wait 100 ns for global reset to finish
		//#100;
		
		check_fa(16'h0002, 16'h0004, 16'h0006, 0, 0);
		check_fa(16'h4000, 16'h4000, 16'h8000, 1, 0);
		check_fa(16'hc000, 16'h4000, 16'h0000, 0, 1);
		check_fa(16'h8000, 16'h8000, 16'h0000, 1, 1);

	end
	
	task check_fa;
	  input [15:0] i_a;
	  input [15:0] i_b;
	  input [15:0] exp_s;
	  input exp_v;
	  input exp_c;
	  
	  begin   
			a = i_a;    b = i_b;
			#1;
			if ((sum !== exp_s) || (carry !== exp_c) || (overflow !== exp_v)) begin
				 $display("Error @%dns S=%b, eS=%b  |  C=%b, eC=%b  |  V=%b, eV=%b", $time, sum, exp_s, carry, exp_c, overflow, exp_v);
				 end
			$display ("======================");
		end
	 endtask
  
endmodule

