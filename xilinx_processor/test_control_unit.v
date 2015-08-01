`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   02:23:39 04/29/2015
// Design Name:   control_unit
// Module Name:   /media/BELGELER/Workspaces/Xilinx/processor/test_control_unit.v
// Project Name:  processor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: control_unit
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_control_unit;

	// Inputs
	reg [15:0] IR;

	// Outputs
	wire [2:0] reg_read_adr1_d;
	wire [2:0] reg_read_adr2_d;
	wire [2:0] reg_write_adr_d;
	wire reg_write_d;
	wire ALU_source2_d;
	wire [7:0] ALU_con_d;
	wire [15:0] offset_register_d;
	wire mem_write_d;
	wire mem_to_reg_d;
	wire branch_d;
	wire [3:0] branch_condition_d;
	wire IEN_d;
	wire IOF_d;
	wire RTI_d;

	// Instantiate the Unit Under Test (UUT)
	control_unit uut (
		.IR(IR), 
		.reg_read_adr1_d(reg_read_adr1_d), 
		.reg_read_adr2_d(reg_read_adr2_d), 
		.reg_write_adr_d(reg_write_adr_d), 
		.reg_write_d(reg_write_d), 
		.ALU_source2_d(ALU_source2_d), 
		.ALU_con_d(ALU_con_d), 
		.offset_register_d(offset_register_d), 
		.mem_write_d(mem_write_d), 
		.mem_to_reg_d(mem_to_reg_d), 
		.branch_d(branch_d), 
		.branch_condition_d(branch_condition_d), 
		.IEN_d(IEN_d),
		.IOF_d(IOF_d),
		.RTI_d(RTI_d)
	);

	initial begin
		// Initialize Inputs
		IR = 0;

		// Wait 100 ns for global reset to finish
		//#100;
        
		IR = 16'h1000;
		
		#1;
		
		IR = 16'h2000;
		
		#1;

	end
      
endmodule

