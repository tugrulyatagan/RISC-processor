`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:21:52 04/24/2015 
// Design Name: 
// Module Name:    ADD 
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
module ADD(
	input [15:0] a,
	input [15:0] b,
	output [15:0] sum,
	output overflow,
	output carry
	);
	
	wire [15:0] A;
	wire [15:0] B;
	wire [15:0] S;
	wire [15:0] C;
	
	assign A = a;
	assign B = b;

	genvar i;
	generate
		for (i=0; i<16; i=i+1) begin : full_adder_slices
			if (i == 0) 
				full_adder fa0(A[i], B[i], 1'b0, S[i], C[i]);
			else 
				full_adder fa(A[i], B[i], C[i-1], S[i], C[i]);
		end
	endgenerate
		
	assign sum = S;
	assign carry = C[15];
	assign overflow = C[15] ^ C[14];

endmodule
