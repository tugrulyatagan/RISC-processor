`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:35:36 04/25/2015 
// Design Name: 
// Module Name:    IR_fetch 
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
module IR_fetch(
	input clock,
	input PC_source,
	input [11:0] PC_offset,
	input [11:0] ISR_adr,
	input branch_ISR,
	input stall_d,
	input stall_f,
	input flush_d,
	output reg [15:0] IR,
	output reg [11:0] PC
	);

	wire	[15:0]	rom_data_out;
	wire flush_decode;
	
	assign flush_decode = flush_d || branch_ISR;
			
	initial begin	
		IR = 0;
		PC = 0;
		flush_d_temp = 0;
	end

	ROM_4K instruction_rom (
		.clka(clock), // input clka
		.ena(~stall_d),
		.addra(PC), // input [11 : 0] addra
		.douta(rom_data_out) // output [15 : 0] douta
	);
	
	reg [11:0] nextOff;
	reg [11:0] nextPC;
	
	always @(*) begin
		case (PC_source) 
			0: nextOff <= PC + 1;
			1: nextOff <= PC + PC_offset;
		endcase
		
		case (branch_ISR)
			0: nextPC <= nextOff;
			1: nextPC <= ISR_adr;
		endcase
	end

	reg flush_d_temp;


	always @(posedge clock) begin
		if (stall_f == 0) begin
			PC = nextPC;
		end
		if (flush_decode == 1) begin
			flush_d_temp <= 1;
		end
		else begin
			flush_d_temp <= 0;
		end
	end
	
	
	reg hiphop;
	
	always @(rom_data_out ) begin  // or flush_d_temp	
		if (stall_d == 0 && flush_d_temp == 0) begin
			IR <= rom_data_out;
		end
		else if (flush_d_temp == 1) begin
			IR <= 0;
		end
	end
	
endmodule
