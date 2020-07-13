`timescale 1ns / 1ps
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
	 output reg [31:0] PC,
    output [31:0] Instr
    );
	 
	 reg [31:0] IM [1023:0];
	 
	 assign Instr = IM[PC[11:2]];
	 
	 initial begin
		PC = 32'h00003000;
		$readmemh("code.txt",IM);
	 end
	 
	 always @(posedge clk) begin
		if (reset) begin
			PC = 32'h00003000;
		end
		else begin
			PC <= NPC;
		end
	 end

endmodule
