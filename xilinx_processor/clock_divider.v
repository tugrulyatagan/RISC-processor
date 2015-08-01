`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:59:47 05/08/2015 
// Design Name: 
// Module Name:    clock_divider 
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


parameter DIVIDER = 4;

module clock_divider(
		input in_clk,
		output reg out_clk
	);

	reg [32:0] m;
	initial  begin
		m = 0;
	end
	
	always @ (posedge (in_clk)) begin
		if (m < DIVIDER - 1)
			m <= m + 1;
		else
			m <= 0;
	end

	always @ (m) begin
		if (m < DIVIDER/2)
			out_clk <= 1;
		else
			out_clk <= 0;
	end


/*module clock_divider(
	input in_clk,
	input [15:0] divider_factor,
	output reg out_clk
	);
	

	reg [31:0] m;
	reg [31:0] divider;
	reg [31:0] half_divider;

	initial begin
		m = 0;
		divider = 2;
		half_divider = 1;
	end

	always @(posedge in_clk) begin
		if (m < divider - 1)
			m <= m + 1;
		else   
			m <= 0;
	end

	always @(in_clk) begin
		if (divider_factor == 0)
			out_clk <= in_clk;
		else if (m < half_divider)
			out_clk <= 1;
		else
			out_clk <= 0;
	end
	
	always @(out_clk) begin
		divider = 2**divider_factor;
		half_divider = divider/2;
	end*/
	
endmodule
