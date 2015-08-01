`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:51:59 05/12/2015 
// Design Name: 
// Module Name:    pipeline_control_registers 
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
module pipeline_control_registers(
	input clock,
	
	input flush_e,
	
	input reg_write_d,
	input [2:0] reg_write_adr_d,
	input mem_to_reg_d,
	input mem_write_d,
	input [7:0] ALU_con_d,
	input ALU_source2_d,
	input [15:0] offset_register_d,
	input [2:0] reg_read_adr1_d,
	input [2:0] reg_read_adr2_d,
	
	output reg reg_write_e,
	output reg [2:0] reg_write_adr_e,
	output reg mem_to_reg_e,
	output reg mem_write_e,
	output reg [7:0] ALU_con_e,
	output reg ALU_source2_e,
	output reg [15:0] offset_register_e,
	output reg [2:0] reg_read_adr1_e,
	output reg [2:0] reg_read_adr2_e,
	
	output reg reg_write_m,
	output reg [2:0] reg_write_adr_m,
	output reg mem_to_reg_m,
	output reg mem_write_m,
	
	output reg reg_write_w,
	output reg [2:0] reg_write_adr_w,
	output reg mem_to_reg_w
	);

	initial begin
		reg_write_e = 0;
		reg_write_adr_e = 0;
		mem_to_reg_e = 0;
		mem_write_e = 0;
		ALU_con_e = 0;
		ALU_source2_e = 0;
		offset_register_e = 0;
		reg_read_adr1_e = 0;
		reg_read_adr2_e = 0;
	
		reg_write_m = 0;
		reg_write_adr_m = 0;
		mem_to_reg_m = 0;
		mem_write_m = 0;
		
		reg_write_w = 0;
		reg_write_adr_w = 0; 
		mem_to_reg_w = 0;
	
	end


	always @ (posedge clock) begin
		case (flush_e)
			0: begin
				reg_write_e <= reg_write_d;
				reg_write_adr_e <= reg_write_adr_d;
				mem_to_reg_e <= mem_to_reg_d;
				mem_write_e <= mem_write_d;
				ALU_con_e <= ALU_con_d;
				ALU_source2_e <= ALU_source2_d;
				offset_register_e <= offset_register_d;
				reg_read_adr1_e <= reg_read_adr1_d;
				reg_read_adr2_e <= reg_read_adr2_d;
			end
			1: begin
				reg_write_e <= 0;
				reg_write_adr_e <= 0;
				mem_to_reg_e <= 0;
				mem_write_e <= 0;
				ALU_con_e <= 0;
				ALU_source2_e <= 0;
				offset_register_e <= 0;
				reg_read_adr1_e <= 0;
				reg_read_adr2_e <= 0;
			end
		endcase
		
		reg_write_m <= reg_write_e;
		reg_write_adr_m <= reg_write_adr_e;
		mem_to_reg_m <= mem_to_reg_e;
		mem_write_m <= mem_write_e;
		
		reg_write_w <= reg_write_m;
		reg_write_adr_w <= reg_write_adr_m; 
		mem_to_reg_w <= mem_to_reg_m;
	end

endmodule
