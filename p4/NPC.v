`timescale 1ns / 1ps
`include "define.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:22:56 11/26/2018 
// Design Name: 
// Module Name:    NPC 
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
///////////////////////////////////////////////////////////////
module NPC(
/////////////////////
    input [15:0] Imm,
    input [25:0] Jal,
    input [31:0] rs,
    input [1:0] Btr,
    input [31:0] PC,
    output [31:0] PC4,
    output reg [31:0] NPC
    );
	 
	 wire [1:0] Br;
	 assign Br = Btr;
	 assign PC4 = PC + 4;
	 
	 always @(*) begin
		if (Br == `Br_4) begin
			NPC <= PC + 4;
		end
		if (Br == `Br_beq) begin
			NPC <= PC + 4 + {{14{Imm[15]}},Imm,2'b0};
		end
		if (Br == `Br_jal) begin
			NPC <= {PC[31:28] ,Jal,2'b0};
		end
		if (Br == `Br_jr) begin
			NPC <= rs;
		end
	 end

endmodule
