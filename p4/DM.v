`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:33:37 11/26/2018 
// Design Name: 
// Module Name:    DM 
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
module DM(
    input [9:0] A,
    input [31:0] Input,
    input clk,
    input reset,
    input MemWr,
    output [31:0] D
    );
	 
	 reg [31:0] DM [1023:0];
	 assign D = DM[A];
	 integer i;
	 
	 initial begin
		for ( i = 0; i < 1024; i = i + 1 )
			DM[i] = 0;
	 end
	 
	 always @(posedge clk) begin
		if (reset) begin
			for ( i = 0; i < 1024; i = i + 1 )
				DM[i] <= 0;
		end
		else begin
			if (MemWr) begin
				DM[A] <= Input;
				$display("@%h: *%h <= %h",ifu.PC, {20'b0,A,2'b0},Input);
			end
		end
	 end

endmodule
