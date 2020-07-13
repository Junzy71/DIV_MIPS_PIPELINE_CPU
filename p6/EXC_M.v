`timescale 1ns / 1ps
`include "define.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:19:13 12/25/2018 
// Design Name: 
// Module Name:    EXC_M 
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
module EXC_M(
    input [31:0] Addr,
    input [31:0] IR,
    output [6:2] ExcCode
    );
	 
	 wire [5:0] op = IR[31:26];
	 
	 wire AdEL = (op == `lw) ? ((Addr[0] != 0 || Addr[1] != 0) || 
										 (Addr > 32'h00002ffc && Addr < 32'h00007f00) || 
										 (Addr > 32'h00007f0b && Addr < 32'h00007f10) || 
										 (Addr > 32'h00007f1b)) : 0;
										 
	 wire AdES = (op == `sw) ? ((Addr[0] != 0 || Addr[1] != 0) || 
										 (Addr > 32'h00002ffc && Addr < 32'h00007f00) || 
										 (Addr > 32'h00007f07 && Addr < 32'h00007f10) || 
										 (Addr > 32'h00007f17)) : 0;
	
	 assign ExcCode = (AdEL) ? 5'b00100 : (AdES) ? 5'b00101 : 5'b0;

endmodule
