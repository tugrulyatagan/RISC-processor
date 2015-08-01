`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:11:15 03/16/2015 
// Design Name: 
// Module Name:    Atlys_Spartan6 
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
module Atlys_Spartan6(
		input clk,
		input [7:0] sw,
		input [5:0] btn,
		input UartRx,
		
		output UartTx,
		output [7:0] Led
	);	
	
	reg IRQ;
	initial begin
		IRQ = 0;
	end
		
	wire [15:0] processor_output;
	assign Led = processor_output[7:0];
	
	
	wire divided_clock;
	clock_divider clk_div(
		.in_clk(clk),
		.out_clk(divided_clock)
	);
	
	processor_16 processor (
		.clock(divided_clock), 
		.IRQ(IRQ), 
		.processor_output(processor_output),
		.processor_input(sw),
		.processor_uart_rx(UartRx),
		.processor_uart_tx(UartTx)
	);

endmodule
