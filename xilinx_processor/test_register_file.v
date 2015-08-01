`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:25:47 04/26/2015
// Design Name:   register_file
// Module Name:   /media/BELGELER/Workspaces/Xilinx/processor/test_register_file.v
// Project Name:  processor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: register_file
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_register_file;

	// Inputs
	reg clock;
	reg flush;
	reg [2:0] read_adr_1;
	reg [2:0] read_adr_2;
	reg [15:0] write_data;
	reg [2:0] write_adr;
	reg write_en;

	// Outputs
	wire [15:0] data_out_1;
	wire [15:0] data_out_2;

	// Instantiate the Unit Under Test (UUT)
	register_file uut (
		.clock(clock), 
		.flush(flush),
		.read_adr_1(read_adr_1), 
		.read_adr_2(read_adr_2), 
		.write_data(write_data), 
		.write_adr(write_adr), 
		.write_en(write_en), 
		.data_out_1(data_out_1), 
		.data_out_2(data_out_2)
	);

	initial begin
		// Initialize Inputs
		clock = 0;
		flush = 0;
		read_adr_1 = 0;
		read_adr_2 = 0;
		write_data = 0;
		write_adr = 0;
		write_en = 0;

		// Wait 100 ns for global reset to finish
		//#100;
		#1;
		 		 
		write_en = 1;
		write_adr = 0;
		write_data = 16'h3131;
		read_adr_1 = 0;
		
		#2;
		
		write_en = 1;
		write_adr = 3;
		write_data = 16'h6969;
		
		#2;
		
		write_en = 1;
		write_adr = 5;
		write_data = 16'h0ff0;
		
		#2;
		
		
		write_en = 0;
		read_adr_1 = 2;
		read_adr_2 = 3;
		
		#2;

		flush = 1;
		
		#2;
		
		flush = 0;
		

	end
      
	always #10 clock = !clock;
endmodule

