`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:34:29 12/10/2018 
// Design Name: 
// Module Name:    mips 
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
module mips(
    input clk,
    input reset
    );
	 
	 wire [1:0] addr;
	 wire [7:2] HWInt;
	 wire [31:0] ALUOut,BridgeOut,BridgeIn,DEVIn,DEVOut1,DEVOut2;
	 wire [31:4] M_time = ALUOut[31:4];
	 
	 CPUUUUU cpu(.clk(clk),.reset(reset),.HWInt(HWInt),.BridgeOut(BridgeOut),.ALUOut(ALUOut),.BridgeIn(BridgeIn),.IntReq(IntReq),.MemWr(MemWr));
	 bridge Bridge(.PrAddr(ALUOut),.PrRD(BridgeOut),.PrWD(BridgeIn),.DEV_Addr(addr),.DEV_WD(DEVIn),
						.DEV1_RD(DEVOut1),.DEV2_RD(DEVOut2),.Int0(IRQ0),.Int1(IRQ1),.HWInt(HWInt));
	 timer timer0(.clk(clk),.reset(reset),.Addr(addr),.We(M_time == 28'h00007f0 & (MemWr & !IntReq)),.DataIn(DEVIn),.DataOut(DEVOut1),.IRQ(IRQ0));
	 timer timer1(.clk(clk),.reset(reset),.Addr(addr),.We(M_time == 28'h00007f1 & (MemWr & !IntReq)),.DataIn(DEVIn),.DataOut(DEVOut2),.IRQ(IRQ1));

endmodule
