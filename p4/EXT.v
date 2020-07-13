`timescale 1ns / 1ps
`include "define.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:46:32 11/26/2018 
// Design Name: 
// Module Name:    EXT 
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
module EXT(
    input [15:0] A,
    input [1:0] EXTOp,
    output reg [31:0] B
    );
	 
	 initial begin
		B = 0;
	 end
	 
	 always @(*) begin
		if (EXTOp == `EXT_UP0) begin
			B <= {16'b0,A};
		end
		if (EXTOp == `EXT_LO0) begin
			B <= {A,16'b0};
		end
		if (EXTOp == `EXT_SIGN) begin
			B <= {{16{A[15]}},A};
		end
		if (EXTOp == `EXT_ADDR) begin
			B <= {{14{A[15]}},A,2'b0};
		end
	 end

endmodule
