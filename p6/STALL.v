`timescale 1ns / 1ps
`include "define.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:11:18 12/09/2018 
// Design Name: 
// Module Name:    STALL 
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
module STALL(
    input [31:0] Instr,
	 input [1:0] Tuse_rs,
	 input [1:0] Tuse_rt,
	 input [2:0] RES_E,
	 input [2:0] RES_M,
	 input [2:0] RES_W,
	 input [4:0] A3_E,
	 input [4:0] A3_M,
	 input [4:0] A3_W,
    output stall
    );
	 
	 wire [4:0] A1 = Instr[25:21];
	 wire [4:0] A2 = Instr[20:16];
	 
	 wire stall_rs0_E1 = ((Tuse_rs == `Tuse_0) && (RES_E == `RES_ALU) && (A1 == A3_E) && (A1 != 0));
	 wire stall_rs0_E2 = ((Tuse_rs == `Tuse_0) && (RES_E == `RES_DM) && (A1 == A3_E) && (A1 != 0));
	 wire stall_rs0_M2 = ((Tuse_rs == `Tuse_0) && (RES_M == `RES_DM) && (A1 == A3_M) && (A1 != 0));
	 wire stall_rs1_E2 = ((Tuse_rs == `Tuse_1) && (RES_E == `RES_DM) && (A1 == A3_E) && (A1 != 0));
	 
	 wire stall_rt0_E1 = ((Tuse_rt == `Tuse_0) && (RES_E == `RES_ALU) && (A2 == A3_E) && (A2 != 0));
	 wire stall_rt0_E2 = ((Tuse_rt == `Tuse_0) && (RES_E == `RES_DM) && (A2 == A3_E) && (A2 != 0));
	 wire stall_rt0_M2 = ((Tuse_rt == `Tuse_0) && (RES_M == `RES_DM) && (A2 == A3_M) && (A2 != 0));
	 wire stall_rt1_E2 = ((Tuse_rt == `Tuse_1) && (RES_E == `RES_DM) && (A2 == A3_E) && (A2 != 0));
	 
	 wire stall_rs = (stall_rs0_E1 || stall_rs0_E2 || stall_rs0_M2 || stall_rs1_E2);
	 wire stall_rt = (stall_rt0_E1 || stall_rt0_E2 || stall_rt0_M2 || stall_rt1_E2);
	 
	 assign stall = (stall_rs || stall_rt);

endmodule
