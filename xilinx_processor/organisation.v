`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:48:36 05/12/2015 
// Design Name: 
// Module Name:    organisation 
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
module organisation(
		input clock,

		input [2:0] reg_read_adr1,
		input [2:0] reg_read_adr2,
		input [2:0] reg_write_adr,
		input reg_write,
		input flush_e,
		
		input [1:0] forward1,
		input [1:0] forward2,
		
		input [7:0] ALU_con,
		input ALU_source2,
		input [15:0] offset,
	
		input mem_write,
		input mem_to_reg,
		
		input [15:0] processor_input,
		input processor_uart_rx,
	
		output N, 
		output Z, 
		output C, 
		output V,
		
		output [15:0] processor_output,
		output processor_uart_tx,
		output internal_IRQ
	);
	
	reg [15:0] ram_data_in_m;
	reg [15:0] ALU_data_out_w;
	reg [15:0] ALU_data_out_m;


	reg [15:0] ALU_data_in1;
	reg [15:0] ALU_data_in2;
	reg [15:0] ram_data_in_e;


	reg [15:0] result_w;

	wire [15:0] reg_file_data_out1_e;
	wire [15:0] reg_file_data_out2_e;
	
	wire [15:0] RAM_data_out_w;
	
	wire [15:0] ALU_out;
	
	
	IO_memory IO_memory (
		.clock(clock), 
		.IO_write(mem_write), 
		.IO_address(ALU_data_out_m[11:0]), 
		.IO_data_in(ram_data_in_m), 
		.IO_data_out(RAM_data_out_w),
		.processor_input(processor_input),
		.processor_output(processor_output),
		.processor_uart_rx(processor_uart_rx),
		.processor_uart_tx(processor_uart_tx),
		.internal_IRQ(internal_IRQ)
		);
	
	register_file reg_file (
		.clock(clock), 
		.flush(flush_e),
		.read_adr_1(reg_read_adr1), 
		.read_adr_2(reg_read_adr2), 
		.write_data(result_w), 
		.write_adr(reg_write_adr), 
		.write_en(reg_write), 
		.data_out_1(reg_file_data_out1_e), 
		.data_out_2(reg_file_data_out2_e)
	);

	ALU_16 ALU (
		.clock(clock),
		.ALU_data_in1(ALU_data_in1), 
		.ALU_data_in2(ALU_data_in2), 
		.ALU_control(ALU_con), 
		.ALU_data_out(ALU_out), 
		.N(N), 
		.Z(Z), 
		.C(C), 
		.V(V)
	);

	always @(*) begin
		case (forward1)
			2'h0: begin
				ALU_data_in1 <= reg_file_data_out1_e;
			end
			2'h1: begin
				ALU_data_in1 <= ALU_data_out_m;
			end
			2'h2: begin
				ALU_data_in1 <= result_w;
			end
		endcase
		
		case (forward2)
			2'h0: begin
				ram_data_in_e <= reg_file_data_out2_e;
			end
			2'h1: begin
				ram_data_in_e <= ALU_data_out_m;
			end
			2'h2: begin
				ram_data_in_e <= result_w;
			end
		endcase
		
		case (ALU_source2)
			0: begin
				ALU_data_in2 = ram_data_in_e;
			end
			1: begin
				ALU_data_in2 = offset;
			end
		endcase
		
		case (mem_to_reg)
			0: begin
				result_w <= ALU_data_out_w;
			end
			1: begin
				result_w <= RAM_data_out_w;
			end
		endcase

	end


	always @(posedge clock) begin
		ram_data_in_m <= ram_data_in_e;
		ALU_data_out_m <= ALU_out;
		ALU_data_out_w <= ALU_data_out_m;
	end
	
endmodule
