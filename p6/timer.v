`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:29:06 12/25/2018 
// Design Name: 
// Module Name:    timer 
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
module timer(
    input clk,
    input reset,
    input [3:2] Addr,
    input We,
    input [31:0] DataIn,
    output [31:0] DataOut,
    output IRQ
    );
	 
	 reg [31:0] CTRL,PRESET,COUNT;
	 wire IM = CTRL[3];
	 wire [1:0] MODE = CTRL[2:1];
	 reg [1:0] state;
	 reg IRQt;
	 
	 assign IRQ = IRQt & IM;
	 assign DataOut = (Addr == 2'b00) ? CTRL :
							(Addr == 2'b01) ? PRESET : COUNT;
	 
	 `define IDLE 2'b00
	 `define LOAD 2'b01
	 `define CNT 2'b10
	 `define INT 2'b11
	 
	 initial begin
		CTRL = 32'b0;
		PRESET = 32'b0;
		COUNT = 32'b0;
		IRQt = 0;
		state = 0;
	 end
	 
	 always @(posedge clk) begin
		if (reset) begin
			CTRL = 32'b0;
			PRESET = 32'b0;
			COUNT = 32'b0;
			IRQt = 0;
			state = 0;
		end
		else if (We) begin
			if (Addr == 2'b00) CTRL <= DataIn;
			else if (Addr == 2'b01) PRESET <= DataIn;
		end
		else begin
			case (state)
				`IDLE:begin
							if (CTRL[0]) begin
								state <= `LOAD;
								IRQt <= 0;
							end
							else state <= `IDLE;
						end
				`LOAD:begin
							COUNT <= PRESET;
							state <= `CNT;
						end
				`CNT:begin
							if (!CTRL[0]) state <= `IDLE;
							else if (CTRL[0] && COUNT < 2) begin
								IRQt <= 1;
								state <= `INT;
								COUNT <= COUNT -1;
							end
							else COUNT <= COUNT - 1;
						end
				`INT:begin
							if (MODE == 2'b00) begin
								CTRL[0] <= 0;
								state <= `IDLE;
							end
							else begin
								IRQt <= 0;
								state <= `IDLE;
							end
						end
			endcase
		end
	 end

endmodule
