`timescale 1ns / 1ps
`include "define.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:29:54 11/27/2018 
// Design Name: 
// Module Name:    datapath 
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
module datapath(
    input reset,
    input clk,
    output [31:0] instr,
    input [1:0] Br,
    input [1:0] RegIn,
    input RegWr,
    input [1:0] EXTOp,
    input ALUsrc,
    input [2:0] ALUOp,
    input MemWr,
    input [1:0] ToReg
    );
	 
	 wire [31:0] NPC, PC, PC4;
	 wire [31:0] GRFout1, GRFout2, GRFin;
	 wire [31:0] ALUin2, ALUout, EXTout, DMout;
	 wire [4:0] GRFout_addr;
	 wire [1:0] br;
	 
	 IFU ifu(.NPC(NPC),.clk(clk),.reset(reset),.PC(PC),.Instr(instr));
	 NPC npc(.Imm(instr[15:0]),.Jal(instr[25:0]),.rs(GRFout1),.Btr(br),.PC(PC),.PC4(PC4),.NPC(NPC));
	 ALU alu(.A(GRFout1),.B(ALUin2),.ALUOp(ALUOp),.C(ALUout));
	 EXT ext(.A(instr[15:0]),.EXTOp(EXTOp),.B(EXTout));
	 DM dm(.A(ALUout[11:2]),.Input(GRFout2),.clk(clk),.reset(reset),.MemWr(MemWr),.D(DMout));
	 GRF grf(.clk(clk),.reset(reset),.WE(RegWr),.A1(instr[25:21]),.A2(instr[20:16]),.A3(GRFout_addr),.WD(GRFin),.RD1(GRFout1),.RD2(GRFout2));
	 
	 assign br = (Br == `Br_beq) ? (ALUout == 0 ? `Br_4 : Br ) : Br;
	 
	 assign ALUin2 = (ALUsrc) ? EXTout : GRFout2;

	 assign GRFout_addr = (RegIn == `RegIn_rs) ? instr[20:16] : 
								((RegIn == `RegIn_rt) ? instr[15:11] :
								((RegIn == `RegIn_31) ? 5'b11111 : 5'b00000));
	 assign GRFin = (ToReg == `ToReg_ALU) ? ALUout : 
						((ToReg == `ToReg_DM) ? DMout :
						((ToReg == `ToReg_NPC) ? PC4 : 32'b00000));

endmodule
