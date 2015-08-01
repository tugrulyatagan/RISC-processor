`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:18:00 03/16/2015 
// Design Name: 
// Module Name:    ALU_16 
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
module ALU_16(
	input clock, 
	input [15:0] ALU_data_in1,
	input [15:0] ALU_data_in2,
	input [7:0] ALU_control,
	output [15:0] ALU_data_out,
	output reg N,
	output reg Z,
	output reg C,
	output reg V
	);

	wire [3:0] operation, update;
	assign operation = ALU_control[3:0];
	assign update = ALU_control[7:4];
	
	reg [15:0] result;
	wire [15:0] CSLres, ADDres, SUBres;
	wire ADDv, ADDc, SUBv, SUBc;
	
	reg c, v;
	
	CSL circular_shift_left(.din(ALU_data_in1), .amount(ALU_data_in2), .dout(CSLres));
	ADD adder(.a(ALU_data_in1), .b(ALU_data_in2), .sum(ADDres), .overflow(ADDv), .carry(ADDc));
	SUB subtractor(.a(ALU_data_in1), .b(ALU_data_in2), .sub(SUBres), .overflow(SUBv), .carry(SUBc));

	initial begin
		N = 0;
		Z = 0;
		C = 0;
		V = 0;
		c = 0;
		v = 0;
	end

	always @(*)	begin
		case (operation)
			// AND
			4'h0: result = ALU_data_in1 & ALU_data_in2;
			
			// OR
			4'h1: result = ALU_data_in1 | ALU_data_in2;
			
			// XOR
			4'h2: result = ALU_data_in1 ^ ALU_data_in2;
			
			// LSL			
			4'h3: begin
				result = ALU_data_in1 << ALU_data_in2;
				c = ALU_data_in1[15 - ALU_data_in2 + 1];
			end
			
			// LSR
			4'h4: begin
				result = ALU_data_in1 >> ALU_data_in2;
				c = ALU_data_in1[ALU_data_in2 - 1];
			end
			
			// ASR
			4'h5: begin
				result = ALU_data_in1 >>> ALU_data_in2;
				c = ALU_data_in1[ALU_data_in2 - 1];
			end
			
			// CSL
			4'h6: begin
				result = CSLres;
				c = ALU_data_in1[15 - ALU_data_in2 + 1];
			end
			
			// ADD
			4'h7: begin
				result = ADDres;
				c = ADDc;
				v = ADDv;
			end 
			
			// SUB
			4'h8: begin
				result = SUBres;
				c = SUBc;
				v = SUBv;
			end
			
			// NEG
			4'h9: result = -ALU_data_in1;
			
			// NOT
			4'ha: result = ~ALU_data_in1;
			
			// MUL
			4'hb: result = ALU_data_in1 * ALU_data_in2;
			
			// Transfer A
			4'he: result = ALU_data_in1;
			
			// Transfer B
			4'hf: result = ALU_data_in2;
		endcase
	end
	
	
	always @(negedge clock)	begin
		if (update[3]) begin
			N = result[15];
		end
		if (update[2]) begin
			Z = (result  == 0);
		end
		if (update[1]) begin
			C = c;
		end
		if (update[0]) begin
			V = v;
		end
	end
	
	
	assign ALU_data_out = result;
		
endmodule