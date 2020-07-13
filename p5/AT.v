`timescale 1ns / 1ps
`include "define.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:38:48 12/09/2018 
// Design Name: 
// Module Name:    AT 
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
module AT(
    input [31:0] Instr,
    output [1:0] Tuse_rs,
	 output [1:0] Tuse_rt,
    output [2:0] RES
    );
	 
	 wire [5:0] op = Instr[31:26];
	 wire [5:0] fun = Instr[5:0];
	 
	 assign Tuse_rs = (op == `R) ?
												(fun == `jr) ? `Tuse_0 :
												(fun == `nop) ? `Tuse_no :`Tuse_1 :
							(op == `ori || op == `lw || op == `sw) ? `Tuse_1 :
							(op == `beq) ? `Tuse_0 : `Tuse_no;
	 assign Tuse_rt = (op == `R && (fun == `addu || fun == `subu)) ? `Tuse_1 :
						   (op == `sw) ? `Tuse_2 :
							(op == `beq) ? `Tuse_0 : `Tuse_no;
							
	 assign RES = (op == `R && (fun == `addu || fun == `subu)) ? `RES_ALU :
					  (op == `ori || op == `lui) ? `RES_ALU :
					  (op == `lw) ? `RES_DM :
					  (op == `jal) ? `RES_PC : `RES_NO;

endmodule
