`timescale 1ns / 1ps
`include "define.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:25:24 11/26/2018 
// Design Name: 
// Module Name:    ALU 
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
module ALU(
    input [31:0] A,
    input [31:0] B,
    input [2:0] ALUOp,
    output reg [31:0] C
    );
	 
	 initial begin
		C = 0;
	 end
	 
	 always @(*) begin
		if (ALUOp == `ALU_ADD) begin
			C <= A + B;
		end
		if (ALUOp == `ALU_SUB) begin
			C <= A - B;
		end
		if (ALUOp == `ALU_OR) begin
			C <= A | B;
		end
		if (ALUOp == `ALU_AND) begin
			C <= A & B;
		end
	 end

endmodule
