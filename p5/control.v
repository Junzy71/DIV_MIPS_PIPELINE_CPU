`timescale 1ns / 1ps
`include "define.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:58:27 12/09/2018 
// Design Name: 
// Module Name:    control 
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
module control(
    input [31:0] Instr,
    output branch,
    output [1:0] Br,
    output [1:0] RegIn,
    output RegWr,
    output [1:0] EXTOp,
    output ALUsrc,
    output [2:0] ALUOp,
    output MemWr,
    output [1:0] ToReg
    );
	 
	 wire [5:0] op = Instr[31:26];
	 wire [5:0] fun = Instr[5:0];
	 
	 assign branch = (op == `beq || op == `j || op == `jal || (op == `R && fun == `jr)) ? 1 : 0;
	 
	 assign Br = (op == `j || op == `jal) ? `Br_jal :
					 (op == `R && fun == `jr) ? `Br_jr : `Br_beq;
					 
	 assign RegIn = (op == `R) ? `RegIn_rd :
						 (op == `jal) ? `RegIn_31 : `RegIn_rt;
						 
	 assign RegWr = (op == `R) ?
											(fun == `jr || fun == `nop) ? 0 : 1 :
						 (op == `ori || op == `lw || op == `lui || op == `jal) ? 1 : 0;
						 
	 assign EXTOp = (op == `lui) ? `EXT_LO0 :
						 (op == `lw || op == `sw) ? `EXT_SIGN : `EXT_UP0;
						 
	 assign ALUsrc = (op == `ori || op == `lw || op == `lui || op == `sw) ? 1 : 0;
	 
	 assign ALUOp = (op == `R && fun == `subu) ? `ALU_SUB :
						 (op == `ori) ? `ALU_OR : `ALU_ADD;
						 
	 assign MemWr = (op == `sw) ? 1 : 0;
	 
	 assign ToReg = (op == `lw) ? `ToReg_DM :
						 (op == `jal) ? `ToReg_NPC : `ToReg_ALU;							

endmodule
