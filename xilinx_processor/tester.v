`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    03:01:35 03/17/2015 
// Design Name: 
// Module Name:    tester 
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
module tester();
	reg clk;	
	reg [15:0] d1, d2;
	
	wire [15:0] out;
	
	//input [15:0] Processor_Data_In1,
	//input [15:0] Processor_Data_In2,
	//output reg [15:0] Processor_Data_Out
	);

	ALU_16 ALU (
		.ALU_Data_In1(),
		.ALU_Data_In2(),
		.ALU_Data_Out()
		.ALU_Control,
		.ALU_Data_Out,
		.N, .Z, .C, .V
		);

	initial
	begin
	clk = 0;

	#1;
	
	Processor_Data_In1 = 16'haa;


	end
	
	always begin
		#1 clk = !clk;
	end
endmodule
