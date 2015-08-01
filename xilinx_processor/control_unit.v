`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:56:08 04/29/2015 
// Design Name: 
// Module Name:    control_unit 
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
module control_unit(
	input [15:0] IR,
	
	output reg [2:0] reg_read_adr1_d,
	output reg [2:0] reg_read_adr2_d,
	output reg [2:0] reg_write_adr_d,
	output reg reg_write_d,
	
	output reg ALU_source2_d,
	output reg [7:0] ALU_con_d,
	
	output reg [15:0] offset_register_d,
	
	output reg mem_write_d,
	output reg mem_to_reg_d,
	
	output reg branch_d,
	output reg [3:0] branch_condition_d,
	
	output reg IEN_d,
	output reg IOF_d,
	output reg RTI_d
	);

	always @(*) begin
		// 1. Inherent Instructions
		casex (IR[15:12])
			4'b0000: begin	
				reg_read_adr1_d = 3'h0;
				reg_read_adr2_d = 3'h0;
				reg_write_adr_d = 3'h0;
				reg_write_d = 0;
				ALU_source2_d = 0;
				ALU_con_d = 8'h00;
				offset_register_d = 16'h0000;
				mem_write_d = 0;
				mem_to_reg_d = 0;
				branch_d = 0;
				branch_condition_d = 4'h0;
				
				case (IR[2:0])				
					// ION
					3'b001: begin
						IEN_d = 1;
						IOF_d = 0;
						RTI_d = 0;
					end
					
					// IOF
					3'b010: begin
						IOF_d = 1;
						IEN_d = 0;
						RTI_d = 0;
					end
					
					// RTI
					3'b011: begin
						RTI_d = 1;
						IEN_d = 0;
						IOF_d = 0;
					end
				endcase
			end
			
			
			// 2. Shift Instructions
			4'b0001: begin
				reg_read_adr1_d = IR[5:3];
				reg_read_adr2_d = 3'h0;
				reg_write_adr_d = IR[2:0];
				reg_write_d = 1;
				ALU_source2_d = 1;
				offset_register_d = {12'h000, IR[9:6]};
				mem_write_d = 0;
				mem_to_reg_d = 0;
				branch_d = 0;
				branch_condition_d = 4'h0;
				IEN_d = 0;
				IOF_d = 0;
				RTI_d = 0;
			
				case (IR[11:10])
					// LSL
					2'b00: ALU_con_d = 8'he3;
					
					// LSR
					2'b01: ALU_con_d = 8'he4;
					
					// ASR
					2'b10: ALU_con_d = 8'he5;
					
					// CSR
					2'b11: ALU_con_d = 8'he6;
				endcase
			end
			
			
			// 3. Add/Subtract Register Immediate Instructions
			4'b001x: begin
				reg_read_adr1_d = IR[5:3];
				reg_read_adr2_d = 3'h0;
				reg_write_adr_d = IR[2:0];
				reg_write_d = 1;
				ALU_source2_d = 1;
				offset_register_d = {10'h000, IR[11:6]};
				mem_write_d = 0;
				mem_to_reg_d = 0;
				branch_d = 0;
				branch_condition_d = 4'h0;
				IEN_d = 0;
				IOF_d = 0;
				RTI_d = 0;

				case (IR[12])
					// Add ADD
					0: ALU_con_d = 8'hf7;
					
					// Add SUB
					1: ALU_con_d = 8'hf8;
				endcase
				
			end
			
			
			// 4. Move/Compare/Add/Subtract Immediate Instructions
			4'b010x: begin
				reg_read_adr2_d = 3'h0;
				ALU_source2_d = 1;
				offset_register_d = {8'h00, IR[7:0]};
				mem_write_d = 0;
				mem_to_reg_d = 0;
				branch_d = 0;
				branch_condition_d = 4'h0;
				IEN_d = 0;
				IOF_d = 0;
				RTI_d = 0;
			
				case (IR[12:11])
					// Move Imm MOV
					2'b00: begin
						reg_read_adr1_d = 3'h0;
						ALU_con_d = 8'hcf;
						reg_write_adr_d = IR[10:8];
						reg_write_d = 1;
					end
					
					// Move Imm CMP
					2'b01: begin
						reg_read_adr1_d = IR[10:8];
						ALU_con_d = 8'hf8;
						reg_write_adr_d = 3'h0;
						reg_write_d = 0;
					end		
					
					// Move Imm ADD
					2'b10: begin
						reg_read_adr1_d = IR[10:8];
						ALU_con_d = 8'hf7;
						reg_write_adr_d = IR[10:8];
						reg_write_d = 1;
					end

					// Move Imm SUB
					2'b11: begin
						reg_read_adr1_d = IR[10:8];
						ALU_con_d = 8'hf8;
						reg_write_adr_d = IR[10:8];
						reg_write_d = 1;
					end
				endcase				
			end
			
			
			// 5. ALU Instructions
			4'b011x: begin
				reg_read_adr1_d = 3'h0;
				reg_read_adr2_d = 3'h0;
				ALU_source2_d = 0;
				offset_register_d = 16'h0000;
				mem_write_d = 0;
				mem_to_reg_d = 0;
				branch_d = 0;
				branch_condition_d = 4'h0;
				IEN_d = 0;
				IOF_d = 0;
				RTI_d = 0;				

				case (IR[12:9])
					// AND
					4'h0: begin
						ALU_con_d = 8'hc0;
						reg_write_adr_d = IR[2:0];
						reg_write_d = 1;
					end

					// OR
					4'h1: begin
						ALU_con_d = 8'hc1;
						reg_write_adr_d = IR[2:0];
						reg_write_d = 1;
					end

					// XOR
					4'h2: begin
						ALU_con_d = 8'hc2;
						reg_write_adr_d = IR[2:0];
						reg_write_d = 1;
					end

					// LSL
					4'h3: begin
						ALU_con_d = 8'he3;
						reg_write_adr_d = IR[2:0];
						reg_write_d = 1;
					end		

					// LSR
					4'h4: begin
						ALU_con_d = 8'he4;
						reg_write_adr_d = IR[2:0];
						reg_write_d = 1;
					end

					// ASR
					4'h5: begin
						ALU_con_d = 8'he5;
						reg_write_adr_d = IR[2:0];
						reg_write_d = 1;
					end

					// CSR
					4'h6: begin
						ALU_con_d = 8'he6;
						reg_write_adr_d = IR[2:0];
						reg_write_d = 1;
					end

					// ADD
					4'h7: begin
						ALU_con_d = 8'hf7;
						reg_write_adr_d = IR[2:0];
						reg_write_d = 1;
					end

					// SUB
					4'h8: begin
						ALU_con_d = 8'hf8;
						reg_write_adr_d = IR[2:0];
						reg_write_d = 1;
					end

					// NEG
					4'h9: begin
						ALU_con_d = 8'hc9;
						reg_write_adr_d = IR[2:0];
						reg_write_d = 1;
					end

					// NOT
					4'ha: begin
						ALU_con_d = 8'hca;
						reg_write_adr_d = IR[2:0];
						reg_write_d = 1;
					end

					// CMP
					4'hb: begin
						ALU_con_d = 8'hf8;
						reg_write_adr_d = 3'h0;
						reg_write_d = 0;
					end

					// TST
					4'hc: begin
						ALU_con_d = 8'hf0;
						reg_write_adr_d = 3'h0;
						reg_write_d = 0;
					end
				endcase
			end


			// 6. Load/Store with Register Offset Instructions
			4'b100x: begin
				// LD/ST Reg LD
				reg_read_adr1_d = IR[5:3];
				reg_read_adr2_d = IR[8:6];
				reg_write_adr_d = IR[2:0];
				reg_write_d = 1;
				ALU_source2_d = 0;
				ALU_con_d = 8'h07;
				offset_register_d = 16'h0000;
				mem_write_d = 0;
				mem_to_reg_d = 1;
				branch_d = 0;
				branch_condition_d = 4'h0;
				IEN_d = 0;
				IOF_d = 0;
				RTI_d = 0;
			end
			

			// 7. Load/Store with Immediate Offset Instructions
			4'b101x: begin
				reg_read_adr1_d = IR[5:3];
				ALU_source2_d = 1;
				ALU_con_d = 8'h07;
				offset_register_d = {10'h000, IR[11:6]};
				branch_d = 0;
				branch_condition_d = 4'h0;
				IEN_d = 0;
				IOF_d = 0;
				RTI_d = 0;

				case (IR[12])
					// LD/ST Imm LD
					0: begin
						reg_read_adr2_d = 3'h0;
						reg_write_adr_d = IR[2:0];
						reg_write_d = 1;
						mem_write_d = 0;
						mem_to_reg_d = 1;
					end
					
					// LD/ST Imm STR
					1: begin
						reg_read_adr2_d = IR[2:0];
						reg_write_adr_d = 3'h0;
						reg_write_d = 0;
						mem_write_d = 1;
						mem_to_reg_d = 0;
					end
				endcase
			end
			
			
			// 8. Conditional Branch Instructions
			4'b110x: begin
				reg_read_adr1_d = 3'h0;
				reg_read_adr2_d = 3'h0;
				reg_write_adr_d = 3'h0;
				reg_write_d = 0;
				ALU_source2_d = 1;
				ALU_con_d = 8'h0f;
				offset_register_d = {7'h00, IR[8:0]};
				mem_write_d = 0;
				mem_to_reg_d = 0;
				branch_d = 1;
				IEN_d = 0;
				IOF_d = 0;
				RTI_d = 0;

				case (IR[12:9])
					// BEQ
					4'h0: branch_condition_d = 4'h0;

					// BNE
					4'h1: branch_condition_d = 4'h1;
					
					// BCS
					4'h2: branch_condition_d = 4'h2;
					
					// BCC
					4'h3: branch_condition_d = 4'h3;
					
					// BMI
					4'h4: branch_condition_d = 4'h4;
					
					// BPL
					4'h5: branch_condition_d = 4'h5;
					
					// BVS
					4'h6: branch_condition_d = 4'h6;
					
					// BVC
					4'h7: branch_condition_d = 4'h7;
					
					// BHI
					4'h8: branch_condition_d = 4'h8;
					
					// BLS
					4'h9: branch_condition_d = 4'h9;
					
					// BGE
					4'ha: branch_condition_d = 4'ha;
					
					// BLT
					4'hb: branch_condition_d = 4'hb;
					
					// BGT
					4'hc: branch_condition_d = 4'hc;
					
					// BLE
					4'hd: branch_condition_d = 4'hd;
				endcase
			end
			
			
			// 9. Unconditional Branch Instruction
			4'b1110: begin
				// Uncond Branch OP
				reg_read_adr1_d = 3'h0;
				reg_read_adr2_d = 3'h0;
				reg_write_adr_d = 3'h0;
				reg_write_d = 0;
				ALU_source2_d = 1;
				ALU_con_d = 8'h0f;
				offset_register_d = {4'h0, IR[11:0]};
				mem_write_d = 0;
				mem_to_reg_d = 0;
				branch_d = 1;
				branch_condition_d = 4'hf;
				IEN_d = 0;
				IOF_d = 0;
				RTI_d = 0;
			end
	
	
			// 10. Move Long Immediate
			4'b1111: begin
				// Move Long OP
				reg_read_adr1_d = 3'h0;
				reg_read_adr2_d = 3'h0;
				reg_write_adr_d = 3'h0;
				reg_write_d = 1;
				ALU_source2_d = 1;
				ALU_con_d = 8'h0f;
				offset_register_d = {4'h0, IR[11:0]};
				mem_write_d = 0;
				mem_to_reg_d = 0;
				branch_d = 0;
				branch_condition_d = 4'h0;
				IEN_d = 0;
				IOF_d = 0;
				RTI_d = 0;
			end


		endcase
	end

endmodule
