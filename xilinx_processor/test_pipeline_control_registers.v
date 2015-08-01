`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:40:09 05/12/2015
// Design Name:   pipeline_control_registers
// Module Name:   /media/BELGELER/Workspaces/Xilinx/processor/test_pipeline_control_registers.v
// Project Name:  processor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: pipeline_control_registers
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_pipeline_control_registers;

	// Inputs
	reg clock;
	reg flush_e;
	reg reg_write_d;
	reg [2:0] reg_write_adr_d;
	reg mem_to_reg_d;
	reg mem_write_d;
	reg [7:0] ALU_con_d;
	reg ALU_source2_d;
	reg [15:0] offset_register_d;
	reg [2:0] reg_read_adr1_d;
	reg [2:0] reg_read_adr2_d;

	// Outputs
	wire reg_write_e;
	wire [2:0] reg_write_adr_e;
	wire mem_to_reg_e;
	wire mem_write_e;
	wire [7:0] ALU_con_e;
	wire ALU_source2_e;
	wire [15:0] offset_register_e;
	wire [2:0] reg_read_adr1_e;
	wire [2:0] reg_read_adr2_e;
	wire reg_write_m;
	wire [2:0] reg_write_adr_m;
	wire mem_to_reg_m;
	wire mem_write_m;
	wire reg_write_w;
	wire [2:0] reg_write_adr_w;
	wire mem_to_reg_w;

	// Instantiate the Unit Under Test (UUT)
	pipeline_control_registers uut (
		.clock(clock), 
		.flush_e(flush_e), 
		.reg_write_d(reg_write_d), 
		.reg_write_adr_d(reg_write_adr_d), 
		.mem_to_reg_d(mem_to_reg_d), 
		.mem_write_d(mem_write_d), 
		.ALU_con_d(ALU_con_d), 
		.ALU_source2_d(ALU_source2_d), 
		.offset_register_d(offset_register_d), 
		.reg_read_adr1_d(reg_read_adr1_d), 
		.reg_read_adr2_d(reg_read_adr2_d), 
		.reg_write_e(reg_write_e), 
		.reg_write_adr_e(reg_write_adr_e), 
		.mem_to_reg_e(mem_to_reg_e), 
		.mem_write_e(mem_write_e), 
		.ALU_con_e(ALU_con_e), 
		.ALU_source2_e(ALU_source2_e), 
		.offset_register_e(offset_register_e), 
		.reg_read_adr1_e(reg_read_adr1_e), 
		.reg_read_adr2_e(reg_read_adr2_e), 
		.reg_write_m(reg_write_m), 
		.reg_write_adr_m(reg_write_adr_m), 
		.mem_to_reg_m(mem_to_reg_m), 
		.mem_write_m(mem_write_m), 
		.reg_write_w(reg_write_w), 
		.reg_write_adr_w(reg_write_adr_w), 
		.mem_to_reg_w(mem_to_reg_w)
	);

	initial begin
		// Initialize Inputs
		clock = 0;
		flush_e = 0;
		reg_write_d = 0;
		reg_write_adr_d = 0;
		mem_to_reg_d = 0;
		mem_write_d = 0;
		ALU_con_d = 0;
		ALU_source2_d = 0;
		offset_register_d = 0;
		reg_read_adr1_d = 0;
		reg_read_adr2_d = 0;

		// Wait 100 ns for global reset to finish
		//#100;
       
		#1;
		#2;
		reg_write_d = 1;
		
		#2;
		reg_write_d = 0;
		
		#2;
		reg_write_d = 1;
		
		#2;
		reg_write_d = 1;

		#2;
		reg_write_d = 1;
		flush_e = 1;
		
		#2;
		flush_e = 0;


		

	end
	
   always #1 clock = !clock;
endmodule

