`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:23:25 12/08/2018 
// Design Name: 
// Module Name:    D 
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
module D(
    input WR,
	 input clk,
	 input reset,
	 input clr,
	 input [31:0] EPC,
	 input [31:0] PC,
    input [31:0] PC8,
    input [31:0] IR,
	 input BD,
	 input [6:2] ExcCode,
    output reg [31:0] PC_D,
    output reg [31:0] PC8_D,
    output reg [31:0] IR_D,
	 output reg BD_D,
	 output reg [6:2] ExcCode_D
    );
	 
	 initial begin
			PC_D = 0;
			PC8_D = 0;
			IR_D = 0;
			BD_D = 0;
			ExcCode_D = 0;
	 end
	 
	 always @(posedge clk) begin
		if (reset) begin
			PC_D <= 0;
			PC8_D <= 0;
			IR_D <= 0;
			BD_D <= 0;
			ExcCode_D <= 0;
		end
		else begin
			if (clr) begin
				PC_D <= EPC;
				PC8_D <= EPC+8;
				IR_D <= 0;
				BD_D <= 0;
				ExcCode_D <= 0;
			end
			else if (WR) begin
				PC_D <= PC;
				PC8_D <= PC8;
				IR_D <= IR;
				BD_D <= BD;
				ExcCode_D <= ExcCode;
			end
		end
	 end

endmodule
