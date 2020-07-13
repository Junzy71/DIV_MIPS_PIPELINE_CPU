`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:39:29 12/10/2018 
// Design Name: 
// Module Name:    CPUUUUU 
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
module CPUUUUU(
    input clk,
    input reset
    );
	 
	 wire [1:0] Br,RegIn,EXTOp,ToReg,Tuse_rs,Tuse_rt;
	 wire [2:0] ALUOp,RES,MRD1_D,MRD2_D,MRD1_E,MRD2_E,MRD2_M,RES_E,RES_M,RES_W;
	 wire [4:0] A3_E,A3_M,A3_W,A1_E,A2_E,A2_M;
	 wire [31:0] IR_D,IR_E,IR_M,IR_W;
	 
	 datapath path(.clk(clk),.reset(reset),.Br(Br),.branch(branch),.RegWr(RegWr),.RegIn(RegIn),.EXTOp(EXTOp),
						.ALUsrc(ALUsrc),.ALUOp(ALUOp),.MemWr(MemWr),.ToReg(ToReg),.RES(RES),.stall(stall),
						.MRD1_D(MRD1_D),.MRD2_D(MRD2_D),.MRD1_E(MRD1_E),.MRD2_E(MRD2_E),.MRD2_M(MRD2_M),.IR_D(IR_D),.IR_E(IR_E),
						.IR_M(IR_M),.IR_W(IR_W),.RES_E(RES_E),.RES_M(RES_M),.RES_W(RES_W),.A1_E(A1_E),.A2_E(A2_E),
						.A2_M(A2_M),.A3_E(A3_E),.A3_M(A3_M),.A3_W(A3_W));
	 control ctrlD(.Instr(IR_D),.branch(branch),.Br(Br),.RegIn(RegIn),.EXTOp(EXTOp));
	 control ctrlE(.Instr(IR_E),.ALUsrc(ALUsrc),.ALUOp(ALUOp));
	 control ctrlM(.Instr(IR_M),.MemWr(MemWr));
	 control ctrlW(.Instr(IR_W),.RegWr(RegWr),.ToReg(ToReg));
	 AT at(.Instr(IR_D),.Tuse_rs(Tuse_rs),.Tuse_rt(Tuse_rt),.RES(RES));
	 STALL Stall(.Instr(IR_D),.Tuse_rs(Tuse_rs),.Tuse_rt(Tuse_rt),.RES_E(RES_E),.RES_M(RES_M),.RES_W(RES_W),.A3_E(A3_E),.A3_M(A3_M),.A3_W(A3_W),.stall(stall));
	 FORWARD forward(.Instr(IR_D),.RES_E(RES_E),.RES_M(RES_M),.RES_W(RES_W),.A1_E(A1_E),.A2_E(A2_E),.A2_M(A2_M),.A3_E(A3_E),.A3_M(A3_M),.A3_W(A3_W),
						  .RD1_D(MRD1_D),.RD2_D(MRD2_D),.RD1_E(MRD1_E),.RD2_E(MRD2_E),.RD2_M(MRD2_M));

endmodule
