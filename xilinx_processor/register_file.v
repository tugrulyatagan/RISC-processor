`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:38:23 04/26/2015 
// Design Name: 
// Module Name:    register_file 
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
module register_file(
	input clock,
	
	input flush,
	
	input [2:0] read_adr_1,
	input [2:0] read_adr_2,
	
	input [15:0] write_data,
	input [2:0] write_adr,
	input write_en,
	
	output reg [15:0] data_out_1,
	output reg [15:0] data_out_2
	);


	reg [15:0] file [7:0];
	
	integer i;
	initial begin
		for (i = 0; i < 8 ; i = i + 1) begin 
			file[i] = 16'h00; 
		end 
	
		data_out_1 = 0;
		data_out_2 = 0;
	end
	
	
	always @(negedge clock) begin
		if (write_en == 1) begin
			file[write_adr] = write_data;
		end
	end

	always @(posedge clock) begin
		case (flush)
			0: begin
				data_out_1 = file[read_adr_1];
				data_out_2 = file[read_adr_2];
			end
			1: begin
				data_out_1 = 0;
				data_out_2 = 0;
			end
		endcase
	end
endmodule
