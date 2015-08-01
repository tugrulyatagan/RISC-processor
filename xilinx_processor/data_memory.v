`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:10:40 05/12/2015 
// Design Name: 
// Module Name:    data_memory 
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
module data_memory(
	input clock,
	input mem_write,
	input [11:0] address,
	input [15:0] data_in,
	
	output reg [15:0] data_out
	
	);

	wire [15:0] memory_data_out;

	RAM_4K data_ram (
		.clka(clock), // input clka
		.wea(mem_write), // input [0 : 0] wea
		.addra(address), // input [11 : 0] addra
		.dina(data_in), // input [15 : 0] dina
		.douta(memory_data_out) // output [15 : 0] douta
	);

	always @(posedge clock) begin
		data_out = memory_data_out;
	end


endmodule
