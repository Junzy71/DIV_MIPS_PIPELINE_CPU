`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:30:47 12/08/2018 
// Design Name: 
// Module Name:    Dpipe 
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
module Dpipe(
    input clk,
	 input reset,
	 input RegWr,
	 input [1:0] Br,
	 input [1:0] EXTOp,
	 input [31:0] PC_D,
    input [31:0] IR_D,
    input [31:0] PC8_D,
	 input [4:0] A3_W,
	 input [31:0] M_WD_src,
	 input [31:0] MF_RD1_D,
	 input [31:0] MF_RD2_D,
	 input [31:0] EPC,
    output [31:0] RD1,
    output [31:0] RD2,
    output [31:0] EXTout,
    output CMPout,
    output [31:0] NPCout
    );
	 
	 wire [31:0] NPC;
	 
	 GRF grf(.clk(clk),.reset(reset),.WE(RegWr),.A1(IR_D[25:21]),.A2(IR_D[20:16]),.A3(A3_W),.WD(M_WD_src),.RD1(RD1),.RD2(RD2));
	 EXT ext(.A(IR_D[15:0]),.EXTOp(EXTOp),.B(EXTout));
	 CMP cmp(.A(MF_RD1_D),.B(MF_RD2_D),.C(CMPout));
	 NPC npc(.Instr(IR_D),.rs(MF_RD1_D),.Br(Br),.PC(PC_D),.EPC(EPC),.NPC(NPCout));
	 

endmodule
