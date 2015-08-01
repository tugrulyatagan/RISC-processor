`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:02:57 04/07/2015 
// Design Name: 
// Module Name:    circular_shift_left 
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
module circular_shift_left(
	input [15:0] din,
	input [15:0] amount,
	output reg [15:0] dout
	);

	reg [15:0] x, y, z;
	
	always @ (din or amount) begin
		if (amount[0] == 1'b1) x = {din[14:0], din[15]}; else x = din;
		if (amount[1] == 1'b1) y = {x[13:0], x[15:14]}; else y = x;
		if (amount[2] == 1'b1) z = {y[11:0], y[15:12]}; else z = y;
		if (amount[3] == 1'b1) dout = {z[7:0], z[15:8]}; else dout = z;	
	end
	
endmodule