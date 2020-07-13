`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:53:31 12/08/2018 
// Design Name: 
// Module Name:    E 
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
module E(
    input clk,
	 input reset,
	 input clr,
	 input [31:0] IR_D,
    input [31:0] PC8_D,
    input [31:0] MF_RD1_D,
    input [31:0] MF_RD2_D,
    input [31:0] EXT,
	 input [4:0] M_RF_A3,
	 input [2:0] RES,
	 input BD_D,
	 input [6:2] ExcCode_D,
    output reg [31:0] IR_E,
    output reg [31:0] PC8_E,
    output reg [4:0] A1_E,
    output reg [4:0] A2_E,
    output reg [4:0] A3_E,
    output reg [31:0] RD1_E,
    output reg [31:0] RD2_E,
    output reg [31:0] EXT_E,
	 output reg [2:0] RES_E,
	 output reg BD_E,
	 output reg [6:2] ExcCode_E
    );
	 
	 initial begin
			IR_E = 0;
			PC8_E = 0;
			A1_E = 0;
			A2_E = 0;
			A3_E = 0;
			RD1_E = 0;
			RD2_E = 0;
			EXT_E = 0;
			RES_E = 0;
			BD_E = 0;
			ExcCode_E = 0;
	end
	 
	 always @(posedge clk) begin
		if (reset) begin
			IR_E <= 0;
			PC8_E <= 0;
			A1_E <= 0;
			A2_E <= 0;
			A3_E <= 0;
			RD1_E <= 0;
			RD2_E <= 0;
			EXT_E <= 0;
			RES_E <= 0;
			BD_E <= 0;
			ExcCode_E <= 0;
		end
		else begin
			if (clr) begin
				IR_E <= 0;
				PC8_E <= PC8_D;
				A1_E <= 0;
				A2_E <= 0;
				A3_E <= 0;
				RD1_E <= 0;
				RD2_E <= 0;
				EXT_E <= 0;
				RES_E <= 0;
				BD_E <= BD_D;
				ExcCode_E <= 0;
			end
			else begin
				IR_E <= IR_D;
				PC8_E <= PC8_D;
				A1_E <= IR_D[25:21];
				A2_E <= IR_D[20:16];
				A3_E <= M_RF_A3;
				RD1_E <= MF_RD1_D;
				RD2_E <= MF_RD2_D;
				EXT_E <= EXT;
				RES_E <= RES;
				BD_E <= BD_D;
				ExcCode_E <= ExcCode_D;
			end
		end
	 end

endmodule
