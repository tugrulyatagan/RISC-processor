`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   00:11:26 05/09/2015
// Design Name:   hazard
// Module Name:   /media/BELGELER/Workspaces/Xilinx/processor/test_hazard.v
// Project Name:  processor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: hazard
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_hazard;

	// Inputs
	reg [2:0] reg_read_adr1_d;
	reg [2:0] reg_read_adr2_d;
	reg [2:0] reg_read_adr1_e;
	reg [2:0] reg_read_adr2_e;
	reg [2:0] reg_write_adr_e;
	reg mem_to_reg_e;
	reg reg_write_m;
	reg [2:0] reg_write_adr_m;
	reg reg_write_w;
	reg [2:0] reg_write_adr_w;
	reg PC_source;

	// Outputs
	wire stall_f;
	wire stall_d;
	wire flush_d;
	wire flush_e;
	wire [1:0] forward1_e;
	wire [1:0] forward2_e;

	// Instantiate the Unit Under Test (UUT)
	hazard uut (
		.reg_read_adr1_d(reg_read_adr1_d), 
		.reg_read_adr2_d(reg_read_adr2_d), 
		.reg_read_adr1_e(reg_read_adr1_e), 
		.reg_read_adr2_e(reg_read_adr2_e), 
		.reg_write_adr_e(reg_write_adr_e), 
		.mem_to_reg_e(mem_to_reg_e), 
		.reg_write_m(reg_write_m), 
		.reg_write_adr_m(reg_write_adr_m), 
		.reg_write_w(reg_write_w), 
		.reg_write_adr_w(reg_write_adr_w), 
		.PC_source(PC_source), 
		.stall_f(stall_f), 
		.stall_d(stall_d), 
		.flush_d(flush_d), 
		.flush_e(flush_e), 
		.forward1_e(forward1_e), 
		.forward2_e(forward2_e)
	);

	initial begin
		// Initialize Inputs
		reg_read_adr1_d = 0;
		reg_read_adr2_d = 0;
		reg_read_adr1_e = 0;
		reg_read_adr2_e = 0;
		reg_write_adr_e = 0;
		mem_to_reg_e = 0;
		reg_write_m = 0;
		reg_write_adr_m = 0;
		reg_write_w = 0;
		reg_write_adr_w = 0;
		PC_source = 0;

		// Wait 100 ns for global reset to finish
		//#100;
        
		// Add stimulus here
		#1;
		reg_write_m = 1;
		reg_write_adr_m = 3;
		reg_read_adr1_e = 3;
		
		#1;
		reg_read_adr1_e = 2;
		
		#1;
		reg_write_w = 1;
		reg_write_adr_w = 2;

		#1;
		reg_write_adr_m = 2;

		#1;
		PC_source = 1;
		
		#1;
		reg_write_adr_e = 5;

		#1;
		reg_read_adr1_d = 5;

		#1;
		mem_to_reg_e = 1;

		
		

	end
      
endmodule

