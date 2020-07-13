`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:13:46 11/26/2018 
// Design Name: 
// Module Name:    GRF 
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
module GRF(
    input clk,
    input reset,
    input WE,
    input [4:0] A1,
    input [4:0] A2,
    input [4:0] A3,
    input [31:0] WD,
    output [31:0] RD1,
    output [31:0] RD2
    );
	 
	 reg [31:0] GRF [31:0];
	 integer i;
	 
	 assign RD1 = (A1 == A3 && WE && A1 != 0) ? WD : GRF[A1];
	 assign RD2 = (A2 == A3 && WE && A2 != 0) ? WD : GRF[A2];
	 
	 initial begin
		for ( i = 0; i < 32; i = i + 1 )
			GRF[i] = 0;
	 end
	 
	 always @(posedge clk) begin
		if (reset) begin
			for ( i = 0; i < 32; i = i + 1 )
				GRF[i] <= 0;
		end
		else begin
			if (WE && A3 != 0) begin
				GRF[A3] <= WD;
				$display("%d@%h: $%d <= %h", $time, w.PC8_W-8, A3,WD);
			end
		end
	 end

endmodule
