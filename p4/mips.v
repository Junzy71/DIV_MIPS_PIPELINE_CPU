`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:04:36 11/28/2018 
// Design Name: 
// Module Name:    mips 
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
module mips(
    input clk,
    input reset
    );
	 
	 wire [31:0] instr;
    wire [1:0] Br, RegIn, EXTOp, ToReg;
	 wire [2:0] ALUOp;
	 
	 datapath path(.reset(reset),.clk(clk),.instr(instr),
						.Br(Br),.RegIn(RegIn),.RegWr(RegWr),.EXTOp(EXTOp),
						.ALUsrc(ALUsrc),.ALUOp(ALUOp),.MemWr(MemWr),.ToReg(ToReg));
	 contol ctrl(.instr(instr),.Br(Br),.RegIn(RegIn),.RegWr(RegWr),.EXTOp(EXTOp),
					 .ALUsrc(ALUsrc),.ALUOp(ALUOp),.MemWr(MemWr),.ToReg(ToReg));
	
endmodule
