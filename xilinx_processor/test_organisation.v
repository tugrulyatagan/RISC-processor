`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:03:44 05/12/2015
// Design Name:   organisation
// Module Name:   /media/BELGELER/Workspaces/Xilinx/processor/test_organisation.v
// Project Name:  processor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: organisation
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_organisation;

	// Inputs
	reg clock;
	reg [2:0] reg_read_adr1;
	reg [2:0] reg_read_adr2;
	reg [2:0] reg_write_adr;
	reg reg_write;
	reg flush_e;
	reg [1:0] forward1;
	reg [1:0] forward2;
	reg [7:0] ALU_con;
	reg ALU_source2;
	reg [15:0] offset;
	reg mem_write;
	reg mem_to_reg;
	reg [15:0] processor_input;


	// Outputs
	wire N;
	wire Z;
	wire C;
	wire V;
	wire [15:0] processor_output;

	// Instantiate the Unit Under Test (UUT)
	organisation uut (
		.clock(clock), 
		.reg_read_adr1(reg_read_adr1), 
		.reg_read_adr2(reg_read_adr2), 
		.reg_write_adr(reg_write_adr), 
		.reg_write(reg_write), 
		.flush_e(flush_e), 
		.forward1(forward1), 
		.forward2(forward2), 
		.ALU_con(ALU_con), 
		.ALU_source2(ALU_source2), 
		.offset(offset), 
		.mem_write(mem_write), 
		.mem_to_reg(mem_to_reg), 
		.processor_input(processor_input),
		.N(N), 
		.Z(Z), 
		.C(C), 
		.V(V),
		.processor_output(processor_output)
	);

	initial begin
		// Initialize Inputs
		clock = 0;
		reg_read_adr1 = 0;
		reg_read_adr2 = 0;
		reg_write_adr = 0;
		reg_write = 0;
		flush_e = 0;
		reg_write = 0;
		forward1 = 0;
		forward2 = 0;
		ALU_con = 0;
		ALU_source2 = 0;
		offset = 0;
		mem_write = 0;
		mem_to_reg = 0;
		processor_input = 0;

		// Wait 100 ns for global reset to finish
		// #100;
        
		#2;
		
		offset = 16'h0003;
		ALU_source2 = 1;
		ALU_con = 8'haf;
		
		#2;
		offset = 0;
		ALU_source2 = 0;
		ALU_con = 0;
		forward1 = 1;
		forward2 = 1;
		
		#2;
		forward1 = 0;
		forward2 = 0;
		reg_write = 1;
		
		#2;
		reg_write = 0;
		
		

	end
	
	always #1 clock = !clock;
  
endmodule

