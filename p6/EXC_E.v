`timescale 1ns / 1ps
`include "define.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:02:57 12/25/2018 
// Design Name: 
// Module Name:    EXC_E 
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
module EXC_E(
    input [31:0] A,
    input [31:0] B,
    input [31:0] IR,
    output [6:2] ExcCode
    );
	 
	 wire [5:0] op = IR[31:26];
	 wire [5:0] fun = IR[5:0];
	 wire [32:0] AA = {A[31],A};
	 wire [32:0] BB = {B[31],B};
	 wire [32:0] tempadd = AA + BB;
	 wire [32:0] tempsub = AA - BB;
	 
	 wire Ov = (op == `R && fun == `add) ? (tempadd[32] != tempadd[31]) :
				  (op == `R && fun == `sub) ? (tempsub[32] != tempsub[31]) : 0;
	 wire AdEL = (op == `lw) ? (tempadd[32] != tempadd[31]) : 0;
 	 wire AdES = (op == `sw) ? (tempadd[32] != tempadd[31]) : 0;
	 
	 assign ExcCode = (Ov) ? 5'b01100 : (AdEL) ? 5'b00100 : (AdES) ? 5'b00101 : 5'b0;

endmodule
