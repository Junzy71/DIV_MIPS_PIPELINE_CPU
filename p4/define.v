`define Br_4 2'b00
`define Br_beq 2'b01
`define Br_jal 2'b10
`define Br_jr 2'b11

`define ALU_ADD 2'b000
`define ALU_SUB 2'b001
`define ALU_OR 2'b010
`define ALU_COM 2'b011

`define EXT_UP0 2'b00
`define EXT_LO0 2'b01
`define EXT_SIGN 2'b10
`define EXT_ADDR 2'b11

`define RegIn_rs 2'b00
`define RegIn_rt 2'b01
`define RegIn_31 2'b10

`define ToReg_ALU 2'b00
`define ToReg_DM 2'b01
`define ToReg_NPC 2'b10

`define R 6'b000000
`define addu 6'b100001
`define subu 6'b100011
`define ori	6'b001101
`define lw 6'b100011
`define sw 6'b101011
`define beq	6'b000100
`define lui	6'b001111
`define nop 6'b000000
`define jal	6'b000011
`define jr 6'b001000
