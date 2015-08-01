`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:29:10 04/05/2015 
// Design Name: 
// Module Name:    alu_tester 
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
module alu_tester();
	reg [15:0] d1, d2;
	reg [7:0] con;
	wire [15:0] out;
	wire n, z, c, v;

	ALU_16 ALU (
		.ALU_Data_In1(d1),
		.ALU_Data_In2(d2),
		.ALU_Control(con),
		.ALU_Data_Out(out),
		.N(n), 
		.Z(z), 
		.C(c), 
		.V(v)
		);

	initial
	begin
	
	d1 = 16'h0004;
	d2 = 16'h0002;
	con = 8'hf8;
	
	#1;
	
	d1 = 16'h0002;
	d2 = 16'h0004;
	con = 8'hf8;
	
	#1;
	
	d1 = 16'h8000;
	d2 = 16'h4000;
	con = 8'hf8;
	
	#1;
	
	d1 = 16'h4000;
	d2 = 16'h8000;
	con = 8'hf8;
	
	end
	
endmodule
