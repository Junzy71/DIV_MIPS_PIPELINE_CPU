`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:39:34 12/25/2018 
// Design Name: 
// Module Name:    bridge 
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
module bridge(
    input [31:0] PrAddr,
    output [31:0] PrRD,
    input [31:0] PrWD,
    output [3:2] DEV_Addr,
    output [31:0] DEV_WD,
    input [31:0] DEV1_RD,
    input [31:0] DEV2_RD,
	 input Int0,
	 input Int1,
	 output [7:2] HWInt
    );
	 
	 assign DEV_Addr = PrAddr[3:2];
	 assign DEV_WD = PrWD;
	 assign PrRD = (PrAddr >= 32'h00007f00 && PrAddr <= 32'h00007f0b) ? DEV1_RD :
						(PrAddr >= 32'h00007f10 && PrAddr <= 32'h00007f1b) ? DEV2_RD : 32'b0;
	 assign HWInt = {4'b0,Int1,Int0};

endmodule
