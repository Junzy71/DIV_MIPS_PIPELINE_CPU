`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:35:26 12/25/2018 
// Design Name: 
// Module Name:    CP0 
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
module CP0(
    input [4:0] A1,
    input [4:0] A2,
    input [31:0] DIn,
    input [31:2] PC8,
    input [6:2] ExcCode,
    input [5:0] HWInt,
	 input BD,
    input We,
    input clk,
    input rst,
    input EXLClr,
    output IntReq,
    output reg [31:0] EPC,
    output [31:0] DOut
    );
	 
	 reg [31:0] SR,Cause,PRId;
	 wire [31:0] PC = {PC8,2'b0} - 8;
	 wire [5:0] IM = SR[15:10];
	 wire IE = SR[0];
	 wire EXL = SR[1];
	 wire hwint = (|(HWInt & IM) & IE & !EXL);
	 assign IntReq = hwint || ((ExcCode != 5'b0) && !EXL);
	 assign DOut = (A1 == 12) ? SR :
						(A1 == 13) ? Cause :
						(A1 == 14) ? EPC : PRId;
	 
	 initial begin
		SR = 32'b0;
		Cause = 32'b0;
		EPC = 32'b0;
		PRId = 32'b0;
	 end
	 
	 always @(posedge clk) begin
		if (rst) begin
			SR = 32'b0;
			Cause = 32'b0;
			EPC = 32'b0;
			PRId = 32'b0;
		end
		else begin
		if (EXLClr) SR[1] = 0;
		if (hwint) begin
			SR <= {16'b0,IM,8'b0,1'b1,IE};
			EPC <= (BD) ? PC-4 : PC;
			Cause[15:10] <= HWInt;
			Cause[6:2] <= 5'b0;
			Cause[31] <= BD;
		end
		else if (IntReq) begin
			SR <= {16'b0,IM,8'b0,1'b1,IE};
			EPC <= (BD) ? PC-4 : PC;
			Cause[15:10] <= HWInt;
			Cause[6:2] <= ExcCode;
			Cause[31] <= BD;
		end
		else if (We) begin
			Cause[15:10] <= HWInt;
			if (A2 == 12) SR <= DIn;
			else if (A2 == 14) EPC <= DIn;
			else if (A2 == 15) PRId <= DIn;
		end
		else if (!EXL) Cause[15:10] <= HWInt;
		end
	 end

endmodule
