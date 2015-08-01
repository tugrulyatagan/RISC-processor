`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:02:42 05/13/2015
// Design Name:   processor_16
// Module Name:   /media/BELGELER/Workspaces/Xilinx/processor/test_processor.v
// Project Name:  processor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: processor_16
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_processor;

	// Inputs
	reg clock;
	reg IRQ;
	reg [15:0] processor_input;

	// Outputs
	wire [15:0] processor_output;

	// Instantiate the Unit Under Test (UUT)
	processor_16 uut (
		.clock(clock), 
		.IRQ(IRQ), 
		.processor_output(processor_output),
		.processor_input(processor_input)
	);

	initial begin
		// Initialize Inputs
		clock = 0;
		IRQ = 0;
		processor_input = 0;
        
		// Add stimulus here
		#20;
		
		processor_input = 0;
		
	end
      
	always #10 clock = !clock;
endmodule

