`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:36:58 05/16/2015 
// Design Name: 
// Module Name:    IO_memory 
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
module IO_memory(
	input clock,
	input IO_write,
	input [11:0] IO_address,
	input [15:0] IO_data_in,
	input [15:0] processor_input,
	input processor_uart_rx,

	output reg [15:0] IO_data_out,
	output reg [15:0] processor_output,
	output processor_uart_tx,
	output internal_IRQ
   );
		
	reg [3:0] IO_selection_enable;
	reg [3:0] IO_selection_enable_next;


	reg [7:0] uart_tx_axis_tdata;
	reg uart_tx_axis_tvalid;
	wire uart_tx_axis_tready;
	
	wire [7:0] uart_rx_axis_tdata;
	wire uart_rx_axis_tvalid;
	reg uart_rx_axis_tready;
	
	reg [15:0] uart_rx_stat, uart_rx_stat_1, uart_rx_stat_2, uart_rx_stat_3, uart_rx_stat_4, uart_rx_stat_5;
			
	initial begin
		IO_data_out = 0;
		processor_output = 0;
		IO_selection_enable = 0;

		IO_selection_enable_next = 0;
		uart_rx_stat = 0;
	end
		
	wire [15:0] ram_data_out;
	RAM_4K data_ram (
		.clka(clock), // input clka
		.ena(1'b1), // input ena
		.wea(IO_write), // input [0 : 0] wea
		.addra(IO_address), // input [11 : 0] addra
		.dina(IO_data_in), // input [15 : 0] dina
		.douta(ram_data_out) // output [15 : 0] douta
	);	

	uart uart_module (
	 .clk(clock),
    .rst(0),
    .input_axis_tdata(uart_tx_axis_tdata),
    .input_axis_tvalid(uart_tx_axis_tvalid),
    .input_axis_tready(uart_tx_axis_tready),
    .output_axis_tdata(uart_rx_axis_tdata),
    .output_axis_tvalid(uart_rx_axis_tvalid),
    .output_axis_tready(uart_rx_axis_tready),
    .rxd(processor_uart_rx),
    .txd(processor_uart_tx),
    .tx_busy(),
    .rx_busy(),
    .rx_overrun_error(),
    .rx_frame_error(),
    .prescale(25000000/(115200*8))
	);


	always @(*) begin
		case (IO_address)
			12'hff0: begin
				IO_selection_enable <= 4'h1; // processor_input
			end
			12'hff1: begin
				IO_selection_enable <= 4'h2; // processor_output
			end	
			12'hff2: begin
				IO_selection_enable <= 4'h3; // UART RX
			end
			12'hff3: begin
				IO_selection_enable <= 4'h4; // UART TX
			end
			default: begin
				IO_selection_enable <= 4'h0; // RAM
			end
		endcase	
	
		// For read
		if (clock == 1) begin
			case (IO_selection_enable_next)
				4'h0: IO_data_out = ram_data_out;  // RAM
				4'h1: IO_data_out = processor_input;  // processor_input
				4'h2: IO_data_out = processor_output; // processor_output
				4'h3: IO_data_out = uart_rx_stat; // UART RX
				4'h4: IO_data_out = {6'h00, uart_tx_axis_tready, uart_tx_axis_tvalid, uart_tx_axis_tdata}; // UART TX
			endcase
		end
	end


	always @(negedge clock) begin
		IO_selection_enable_next <= IO_selection_enable;
		
		// For write
		if (IO_write == 1) begin
			case (IO_selection_enable)  ////////////////////////////////// next olabilir
				4'h2: processor_output <= IO_data_in; // processor_output
				4'h3: uart_rx_axis_tready <= IO_data_in[9]; // UART RX
				4'h4: begin // UART TX
					uart_tx_axis_tdata <= IO_data_in[7:0];
					uart_tx_axis_tvalid <= IO_data_in[8];
				end
			endcase
		end
	end


	always @(posedge clock) begin
		uart_rx_stat_1 = {6'h00, uart_rx_axis_tready, uart_rx_axis_tvalid, uart_rx_axis_tdata};
		uart_rx_stat_2 = uart_rx_stat_1;
		uart_rx_stat_3 = uart_rx_stat_2;
		uart_rx_stat_4 = uart_rx_stat_3;
		uart_rx_stat_5 = uart_rx_stat_4;
		uart_rx_stat = uart_rx_stat_5;
	
	end


endmodule
