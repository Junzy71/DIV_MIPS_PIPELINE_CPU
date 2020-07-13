`timescale 1ns / 1ps
`include "define.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:41:19 12/25/2018 
// Design Name: 
// Module Name:    EXC_F 
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
module EXC_F(
    input [31:0] PC,
	 input [31:0] IR_D,
    input [31:0] IR,
    output [6:2] ExcCode,
	 output BD
    );
	 
	 wire [5:0] op = IR[31:26];
	 wire [5:0] fun = IR[5:0];
	 wire [5:0] op_d = IR_D[31:26];
	 wire [5:0] fun_d = IR_D[5:0];
	 
	 wire AdEL = ((PC[0] != 0 || PC[1] != 0) || (PC < 32'h00003000 || PC > 32'h00004ffc));
	 wire RI = !((op == `R && (fun == `addu || fun == `subu || fun == `add || fun == `sub || fun == `nop || fun == `jr || fun == `AND)) ||
					(op == `ori || op == `sw || op == `lw || op == `beq || op == `lui || op == `j || op == `jal || op == `ANDI || op == `ADDIU) ||
					(IR == `eret || IR[31:21] == `mtc0 || IR[31:21] == `mfc0));
					  
	 assign ExcCode = (AdEL) ? 5'b00100 : (RI) ? 5'b01010 : 5'b0;
	 assign BD = ((op_d == `R && fun_d == `jr) || op_d == `beq || op_d == `j || op_d == `jal) ;

endmodule
