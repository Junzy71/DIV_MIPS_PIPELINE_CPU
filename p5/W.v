`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:16:32 12/08/2018 
// Design Name: 
// Module Name:    W 
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
module W(
    input clk,
	 input reset,
	 input [31:0] IR_M,
    input [31:0] PC8_M,
    input [4:0] A3_M,
    input [31:0] AO_M,
    input [31:0] DMout,
	 input [2:0] RES_M,
    output reg [31:0] IR_W,
    output reg [31:0] PC8_W,
    output reg [4:0] A3_W,
    output reg [31:0] AO_W,
    output reg [31:0] DR_W,
	 output reg [2:0] RES_W
    );
	 
	 initial begin
			IR_W = 0;
			PC8_W = 0;
			A3_W = 0;
			AO_W = 0;
			DR_W = 0;
			RES_W = 0;
		end
	 
	 always @(posedge clk) begin
		if (reset) begin
			IR_W <= 0;
			PC8_W <= 0;
			A3_W <= 0;
			AO_W <= 0;
			DR_W <= 0;
			RES_W <= 0;
		end
		else begin
			IR_W <= IR_M;
			PC8_W <= PC8_M;
			A3_W <= A3_M;
			AO_W <= AO_M;
			DR_W <= DMout;
			RES_W <= RES_M;
		end
	 end

endmodule
