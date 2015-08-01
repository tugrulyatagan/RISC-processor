`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:51:52 05/16/2015
// Design Name:   IO_memory
// Module Name:   /media/BELGELER/Workspaces/Xilinx/processor/test_IO_memory.v
// Project Name:  processor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: IO_memory
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_IO_memory;

	// Inputs
	reg clock;
	reg IO_write;
	reg [11:0] IO_address;
	reg [15:0] IO_data_in;
	reg [15:0] processor_input;

	// Outputs
	wire [15:0] IO_data_out;
	wire [15:0] processor_output;

	// Instantiate the Unit Under Test (UUT)
	IO_memory uut (
		.clock(clock), 
		.IO_write(IO_write), 
		.IO_address(IO_address), 
		.IO_data_in(IO_data_in), 
		.IO_data_out(IO_data_out),
		.processor_input(processor_input),
		.processor_output(processor_output)
	);

	initial begin
		// Initialize Inputs
		clock = 0;
		IO_write = 0;
		IO_address = 0;
		IO_data_in = 0;
		processor_input = 16'h3131;

		// Wait 100 ns for global reset to finish
		//#100;
        
//		#2;
//		IO_address = 12'h001;
//		
//		#2;
//		IO_address = 12'h002;
//		
//		#2;
//		IO_address = 12'h009;
//		IO_data_in = 16'h2121;
//		IO_write = 1;
//
//		#2;
//		IO_address = 12'h002;
//		IO_data_in = 0;
//		IO_write = 0;
//		
//		#2;
//		IO_address = 12'h009;
//
//		#2;
//		IO_address = 12'hff0;
//		
//		#2;
//		IO_address = 12'hff1;
//		IO_data_in = 16'h5555;
//		IO_write = 1;
//
//		#2;
//		IO_write = 0;
//		IO_data_in = 0;
//		IO_address = 12'h001;
//		
//		#2;
//		IO_write = 0;
//		IO_address = 12'h002;	
//
//		#2;
//		IO_address = 12'hff1;

		#30;
		IO_address = 12'h000;
		
		#20;
		IO_address = 12'h00f;

		#20;
		IO_address = 12'h000;
		
		#20;
		IO_address = 12'hff0;

		#40;
		IO_address = 12'h001;
		
		#20;
		IO_address = 12'h000;	
		
		#20;
		IO_address = 12'h00a;
		IO_data_in = 16'h3169;
		IO_write = 1;	

		#20;
		IO_address = 12'h002;
		IO_data_in = 0;
		IO_write = 0;		
		
		#20;
		IO_address = 12'h003;
		
		#20;
		IO_address = 12'h00a;	
		
		#20;
		IO_address = 12'h004;

		#20;
		IO_address = 12'hff0;
		IO_data_in = 16'h3170;
		IO_write = 1;	

		#20;
		IO_address = 12'h002;
		IO_data_in = 0;
		IO_write = 0;
		
		#20;
		IO_address = 12'hff0;
		
		#20;
		IO_address = 12'h004;

		#20;
		IO_address = 12'hff1;
		IO_data_in = 16'h3170;
		IO_write = 1;	

		#20;
		IO_address = 12'h002;
		IO_data_in = 0;
		IO_write = 0;
		
		#20;
		IO_address = 12'hff1;
		
		#20;
		IO_address = 12'h004;

		

	end
   always #10 clock = !clock;
endmodule

