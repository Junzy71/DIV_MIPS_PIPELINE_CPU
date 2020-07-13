`timescale 1ns / 1ps
`include "define.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:15:15 11/26/2018 
// Design Name: 
// Module Name:    IFU 
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
module IFU(
    input [31:0] NPC,
	 input clk,
    input reset,
	 input PCWR,
	 input branch,
	 input IntReq,
	 output [31:0] PCout,
	 output [31:0] PC4,
	 output [31:0] PC8,
    output [31:0] Instr
    );
	 
	 reg [31:0] IM [4095:0];
	 reg [31:0] PC;
	 wire [31:0] PCi = PC - 32'h00003000;
	 
	 assign Instr = IM[PCi[13:2]];
	 assign PCout = PC;
	 assign PC4 = PC + 4;
	 assign PC8 = PC + 8;
	 
	 initial begin
		PC = 32'h00003000;
		$readmemh("code.txt",IM);
		$readmemh("code_handler.txt",IM,1120,2047);
	 end
	 
	 always @(posedge clk) begin
		if (reset) begin
			PC = 32'h00003000;
		end
		else begin
			if (IntReq) begin
				PC <= 32'h00004180;
			end 
		   else if (PCWR) begin
				PC <= branch ? NPC : PC+4;
			end
		end
	 end

endmodule
