`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:13:00 04/24/2015
// Design Name:   ALU_16
// Module Name:   /media/BELGELER/Workspaces/Xilinx/processor/test_alu.v
// Project Name:  processor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ALU_16
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_alu;
	reg clock;

	// Inputs
	reg [15:0] ALU_data_in1;
	reg [15:0] ALU_data_in2;
	reg [7:0] ALU_control;

	// Outputs
	wire [15:0] ALU_data_out;
	wire N;
	wire Z;
	wire C;
	wire V;

	// Instantiate the Unit Under Test (UUT)
	ALU_16 uut (
		.clock(clock),
		.ALU_data_in1(ALU_data_in1), 
		.ALU_data_in2(ALU_data_in2), 
		.ALU_control(ALU_control), 
		.ALU_data_out(ALU_data_out), 
		.N(N), 
		.Z(Z), 
		.C(C), 
		.V(V)
	);

	initial begin
		// Initialize Inputs
		clock = 0;
		ALU_data_in1 = 0;
		ALU_data_in2 = 0;
		ALU_control = 0;

		// Wait 100 ns for global reset to finish
		//#100;
		
		check_alu(16'h8007, 16'hc005, 8'h00, 16'h8005, 0, 0, 0, 0);
		check_alu(16'h000a, 16'h000c, 8'he6, 16'h8005, 1, 0, 0, 0);

	end
      
	task check_alu;
		input [15:0] i_a;
		input [15:0] i_b;
		input [7:0] i_c;
		input [15:0] exp_o;
		input exp_n;
		input exp_z;
		input exp_c;
		input exp_v;	  

	  begin   
			ALU_data_in1 = i_a;    
			ALU_data_in2 = i_b; 
			ALU_control = i_c;
			#1;
			if ((ALU_data_out !== exp_o) || (N !== exp_n) || (Z !== exp_z) || (C !== exp_c) || (V !== exp_v)) begin
				 $display("Error @%dns O=%b, eO=%b  |  N=%b, eN=%b  |  Z=%b, eZ=%b  |  C=%b, eC=%b  |  V=%b, eV=%b", $time, ALU_data_out, exp_o, N, exp_n, Z, exp_z, C, exp_c, V, exp_v);
			end
			$display ("======================");
		end
	endtask
	
	always #1 clock = !clock;

endmodule

