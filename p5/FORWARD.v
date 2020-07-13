`timescale 1ns / 1ps
`include "define.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:40:12 12/09/2018 
// Design Name: 
// Module Name:    FORWARD 
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
module FORWARD(
	 input [31:0] Instr,
	 input [2:0] RES_E,
	 input [2:0] RES_M,
	 input [2:0] RES_W,
	 input [4:0] A1_E,
	 input [4:0] A2_E,
	 input [4:0] A2_M,
	 input [4:0] A3_E,
	 input [4:0] A3_M,
	 input [4:0] A3_W,
    output [2:0] RD1_D,
	 output [2:0] RD2_D,
	 output [2:0] RD1_E,
	 output [2:0] RD2_E,
	 output [2:0] RD2_M
    );
	 
	 wire [4:0] A1_D = Instr[25:21];
	 wire [4:0] A2_D = Instr[20:16]; 
	 
	 assign RD1_D = (A1_D == A3_E && RES_E == `RES_PC && A1_D != 0) ? `MF_PC8_E :
						 (A1_D == A3_M && RES_M == `RES_PC && A1_D != 0) ? `MF_PC8_M :
						 (A1_D == A3_M && RES_M == `RES_ALU && A1_D != 0) ? `MF_AO_M : `MF_RD;
	 assign RD2_D = (A2_D == A3_E && RES_E == `RES_PC && A2_D != 0) ? `MF_PC8_E :
						 (A2_D == A3_M && RES_M == `RES_PC && A2_D != 0) ? `MF_PC8_M :
						 (A2_D == A3_M && RES_M == `RES_ALU && A2_D != 0) ? `MF_AO_M : `MF_RD;
	 assign RD1_E = (A1_E == A3_M && RES_M == `RES_PC && A1_E != 0) ? `MF_PC8_M :
						 (A1_E == A3_M && RES_M == `RES_ALU && A1_E != 0) ? `MF_AO_M :
						 (A1_E == A3_W && RES_W != `RES_NO && A1_E != 0) ? `MF_WD_W :`MF_RD;
	 assign RD2_E = (A2_E == A3_M && RES_M == `RES_PC && A2_E != 0) ? `MF_PC8_M :
						 (A2_E == A3_M && RES_M == `RES_ALU && A2_E != 0) ? `MF_AO_M :
						 (A2_E == A3_W && RES_W != `RES_NO && A2_E != 0) ? `MF_WD_W :`MF_RD;
	 assign RD2_M = (A2_M == A3_W && RES_W != `RES_NO && A2_M != 0) ? `MF_WD_W :`MF_RD;

endmodule
