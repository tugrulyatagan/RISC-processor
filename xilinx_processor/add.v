`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:51:22 04/23/2015 
// Design Name: 
// Module Name:    add 
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
module add(
	input [15:0] a,
	input [15:0] b,
	output reg [15:0] sum,
	output reg overflow,
	output reg carry
	);
	
	reg [16:0] s;
	
   wire   sa = a[15];
   wire   sb = b[15];
   wire   ssum = s[15];

	always @ (*) begin
		s = a + b;
		overflow = sa != sb   ? 0 : sb == ssum ? 0 : 1;
		carry = s[16];
	end

endmodule
