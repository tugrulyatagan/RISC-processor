`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:39:19 05/12/2015
// Design Name:   data_memory
// Module Name:   /media/BELGELER/Workspaces/Xilinx/processor/test_data_memory.v
// Project Name:  processor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: data_memory
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_data_memory;

	// Inputs
	reg clock;
	reg mem_write;
	reg [11:0] address;
	reg [15:0] data_in;

	// Outputs
	wire [15:0] data_out;

	// Instantiate the Unit Under Test (UUT)
	data_memory uut (
		.clock(clock), 
		.mem_write(mem_write), 
		.address(address), 
		.data_in(data_in), 
		.data_out(data_out)
	);

	initial begin
		// Initialize Inputs
		clock = 0;
		mem_write = 0;
		address = 0;
		data_in = 0;

		// Wait 100 ns for global reset to finish
		//#100;
        
		#1;
		
		address = 12'h001;
		
		#2;
		address = 12'h002;
		
		#2;
		address = 12'h003;

		
		
		
	end
	
   always #1 clock = !clock;

endmodule

