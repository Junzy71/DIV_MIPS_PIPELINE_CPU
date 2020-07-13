`timescale 1ns / 1ps
`include "define.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:29:53 11/28/2018 
// Design Name: 
// Module Name:    contol 
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
module contol(
    input [31:0] instr,
    output [1:0] Br,
    output [1:0] RegIn,
    output RegWr,
    output [1:0] EXTOp,
    output ALUsrc,
    output [2:0] ALUOp,
    output MemWr,
    output [1:0] ToReg
    );
	 
	 wire [5:0] op = instr[31:26];
	 wire [5:0] fun = instr[5:0];
	 
	 assign Br = op == `R   ?
								fun == `jr ? `Br_jr : `Br_4 :
					 op == `beq ? `Br_beq :
					 op == `jal ? `Br_jal : `Br_4 ;
	
	
	 assign RegIn = op == `R   ? `RegIn_rt :
					    op == `jal ? `RegIn_31 : `RegIn_rs ;
						 
	 assign RegWr = op == `R   ?
								fun == `jr ? 0 : 1 :
					   (op == `sw || op == `beq) ? 0 : 1 ;
						 
	 assign EXTOp = (op == `lw || op == `sw) ? `EXT_SIGN :
					     op == `lui ? `EXT_LO0 : `EXT_UP0 ;
					
	 assign ALUsrc = (op == `R || op == `beq) ? 0 : 1 ;
						  
	 assign ALUOp = op == `R   ?
								fun == `subu ? `ALU_SUB : `ALU_ADD :
					    op == `ori ? `ALU_OR :
						 op == `beq ? `ALU_COM : `ALU_ADD ;
						 
	 assign MemWr = op == `sw ? 1 : 0;
	 
	 assign ToReg = op == `lw  ? `ToReg_DM :
						 op == `jal ? `ToReg_NPC : `ToReg_ALU ;					 				

endmodule
