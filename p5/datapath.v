`timescale 1ns / 1ps
`include "define.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:47:37 12/08/2018 
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
    input clk,
    input reset,
	 input [1:0] Br,
	 input branch,
	 input RegWr,
	 input [1:0] RegIn,
	 input [1:0] EXTOp,
	 input ALUsrc,
	 input [2:0] ALUOp,
	 input MemWr,
	 input [1:0] ToReg,
	 input [2:0] RES,
	 input stall,
	 input [2:0] MRD1_D,
	 input [2:0] MRD2_D,
	 input [2:0] MRD1_E,
	 input [2:0] MRD2_E,
	 input [2:0] MRD2_M,
	 output [31:0] IR_D,
	 output [31:0] IR_E,
	 output [31:0] IR_M,
	 output [31:0] IR_W,
	 output [2:0] RES_E,
	 output [2:0] RES_M,
	 output [2:0] RES_W,
	 output [4:0] A1_E,
	 output [4:0] A2_E,
	 output [4:0] A2_M,
	 output [4:0] A3_E,
	 output [4:0] A3_M,
	 output [4:0] A3_W
    );
	 
	 wire [31:0] PC,PC4,PC8,IR,GRFout1,GRFout2,EXTout,NPCout,ALUout,DMout;
	 wire [31:0] M_WD_src,MF_RD1_D,MF_RD2_D,MF_RD1_E,MF_RD2_E,MF_RD2_M,M_ALU_B;
	 wire [31:0] PC_D,PC8_D,RD1_E,RD2_E,PC8_E,EXT_E,PC8_M,AO_M,PC8_W,AO_W,DR_W,RD2_M;
	 wire [4:0] M_RF_A3;
	 
	 IFU ifu(.NPC(NPCout),.clk(clk),.reset(reset),.PCWR(!stall),.branch(branchPC),.PCout(PC),.PC4(PC4),.PC8(PC8),.Instr(IR));
	 D d(.WR(!stall),.clk(clk),.reset(reset),.PC(PC),.PC8(PC8),.IR(IR),.PC_D(PC_D),.PC8_D(PC8_D),.IR_D(IR_D));
	 Dpipe dpiple(.clk(clk),.reset(reset),.RegWr(RegWr),.Br(Br),.EXTOp(EXTOp),.PC_D(PC_D),.IR_D(IR_D),.PC8_D(PC8_D),.A3_W(A3_W),.M_WD_src(M_WD_src),
					  .MF_RD1_D(MF_RD1_D),.MF_RD2_D(MF_RD2_D),.RD1(GRFout1),.RD2(GRFout2),.EXTout(EXTout),.CMPout(CMPout),.NPCout(NPCout));
	 E e(.clk(clk),.reset(reset),.clr(stall),.IR_D(IR_D),.PC8_D(PC8_D),.MF_RD1_D(MF_RD1_D),.MF_RD2_D(MF_RD2_D),.EXT(EXTout),.M_RF_A3(M_RF_A3),.RES(RES),
		  .IR_E(IR_E),.PC8_E(PC8_E),.A1_E(A1_E),.A2_E(A2_E),.A3_E(A3_E),.RD1_E(RD1_E),.RD2_E(RD2_E),.EXT_E(EXT_E),.RES_E(RES_E));
	 ALU epipe(.A(MF_RD1_E),.B(M_ALU_B),.ALUOp(ALUOp),.C(ALUout));
	 M m(.clk(clk),.reset(reset),.IR_E(IR_E),.PC8_E(PC8_E),.A2_E(A2_E),.A3_E(A3_E),.RD2_E(MF_RD2_E),.ALUout(ALUout),.RES_E(RES_E),
		  .IR_M(IR_M),.PC8_M(PC8_M),.A2_M(A2_M),.A3_M(A3_M),.RD2_M(RD2_M),.AO_M(AO_M),.RES_M(RES_M));
	 DM mpipe(.A(AO_M[11:2]),.Input(MF_RD2_M),.clk(clk),.reset(reset),.MemWr(MemWr),.D(DMout));
	 W w(.clk(clk),.reset(reset),.IR_M(IR_M),.PC8_M(PC8_M),.A3_M(A3_M),.AO_M(AO_M),.DMout(DMout),.RES_M(RES_M),
		  .IR_W(IR_W),.PC8_W(PC8_W),.A3_W(A3_W),.AO_W(AO_W),.DR_W(DR_W),.RES_W(RES_W));
		  
	 assign branchPC = (Br == `Br_beq) ? (CMPout ? branch : 0) : branch;
	 assign M_WD_src = (ToReg == `ToReg_ALU) ? AO_W :
							 (ToReg == `ToReg_DM)  ? DR_W :
							 (ToReg == `ToReg_NPC) ? PC8_W : 32'b0 ;
	 assign M_ALU_B = ALUsrc ? EXT_E : MF_RD2_E;
	 assign M_RF_A3 = (RegIn == `RegIn_rt) ? IR_D[20:16] :
							(RegIn == `RegIn_rd) ? IR_D[15:11] :
							(RegIn == `RegIn_31) ? 5'b11111 : 5'b00000;
	 
	 assign MF_RD1_D = (MRD1_D == `MF_PC8_E) ? PC8_E :
							 (MRD1_D == `MF_PC8_M) ? PC8_M :
							 (MRD1_D == `MF_AO_M) ? AO_M : GRFout1;
	 assign MF_RD2_D = (MRD2_D == `MF_PC8_E) ? PC8_E :
							 (MRD2_D == `MF_PC8_M) ? PC8_M :
							 (MRD2_D == `MF_AO_M) ? AO_M : GRFout2;
	 assign MF_RD1_E = (MRD1_E == `MF_PC8_M) ? PC8_M :
							 (MRD1_E == `MF_AO_M) ? AO_M :
							 (MRD1_E == `MF_WD_W) ? M_WD_src : RD1_E;
	 assign MF_RD2_E = (MRD2_E == `MF_PC8_M) ? PC8_M :
							 (MRD2_E == `MF_AO_M) ? AO_M :
							 (MRD2_E == `MF_WD_W) ? M_WD_src : RD2_E;
	 assign MF_RD2_M = (MRD2_M == `MF_WD_W) ? M_WD_src : RD2_M;

endmodule
