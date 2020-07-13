`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:09:30 12/08/2018 
// Design Name: 
// Module Name:    M 
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
module M(
    input clk,
	 input reset,
	 input [31:0] IR_E,
    input [31:0] PC8_E,
    input [4:0] A2_E,
    input [4:0] A3_E,
    input [31:0] RD2_E,
    input [31:0] ALUout,
	 input [2:0] RES_E,
    output reg [31:0] IR_M,
    output reg [31:0] PC8_M,
    output reg [4:0] A2_M,
    output reg [4:0] A3_M,
    output reg [31:0] RD2_M,
    output reg [31:0] AO_M,
	 output reg [2:0] RES_M
    );
	 
	 initial begin
			IR_M = 0;
			PC8_M = 0;
			A2_M = 0;
			A3_M = 0;
			RD2_M = 0;
			AO_M = 0;
			RES_M = 0;
	end
	 
	 always @(posedge clk) begin
		if (reset) begin
			IR_M <= 0;
			PC8_M <= 0;
			A2_M <= 0;
			A3_M <= 0;
			RD2_M <= 0;
			AO_M <= 0;
			RES_M <= 0;
		end
		else begin
			IR_M <= IR_E;
			PC8_M <= PC8_E;
			A2_M <= A2_E;
			A3_M <= A3_E;
			RD2_M <= RD2_E;
			AO_M <= ALUout;
			RES_M <= RES_E;
		end
	 end

endmodule
