`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   00:06:35 05/25/2015
// Design Name:   subroutine_stack
// Module Name:   E:/Workspaces/Xilinx/processor/test_subroutine_stack.v
// Project Name:  processor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: subroutine_stack
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_subroutine_stack;

	// Inputs
	reg clock;
	reg subroutine_call;
	reg subroutine_return;
	reg [11:0] PC;

	// Outputs
	wire [11:0] RTS_adr;

	// Instantiate the Unit Under Test (UUT)
	subroutine_stack uut (
		.clock(clock), 
		.subroutine_call(subroutine_call), 
		.subroutine_return(subroutine_return), 
		.PC(PC), 
		.RTS_adr(RTS_adr)
	);

	initial begin
		// Initialize Inputs
		clock = 0;
		subroutine_call = 0;
		subroutine_return = 0;
		PC = 0;

		// Wait 100 ns for global reset to finish
		#90;
        
		subroutine_call = 1;
		subroutine_return = 0;
		PC = 131;
		#20;
		
		subroutine_call = 0;
		subroutine_return = 0;
		PC = 696;
		#40;
		
		
		subroutine_call = 1;
		subroutine_return = 0;
		PC = 5;
		#20;
		
		subroutine_call = 0;
		subroutine_return = 0;
		PC = 696;
		#40;	
		
		subroutine_call = 0;
		subroutine_return = 1;
		PC = 102;
		#20;
		
		subroutine_call = 0;
		subroutine_return = 0;
		PC = 333;
		#20;
		
		
		
		  
		// Add stimulus here

	end
   always #10 clock = !clock;
endmodule

