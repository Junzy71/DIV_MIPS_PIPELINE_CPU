`define Br_beq 2'b00
`define Br_jal 2'b01
`define Br_jr 2'b10

`define ALU_ADD 3'b000
`define ALU_SUB 3'b001
`define ALU_OR 3'b010

`define EXT_UP0 2'b00
`define EXT_LO0 2'b01
`define EXT_SIGN 2'b10

`define RegIn_rt 2'b00
`define RegIn_rd 2'b01
`define RegIn_31 2'b10

`define ToReg_ALU 2'b00
`define ToReg_DM 2'b01
`define ToReg_NPC 2'b10

`define Tuse_0 2'b00
`define Tuse_1 2'b01
`define Tuse_2 2'b10
`define Tuse_no 2'b11

`define RES_NO 3'b000
`define RES_ALU 3'b001
`define RES_DM 3'b010
`define RES_PC 3'b011

`define MF_PC8_E 3'b000
`define MF_PC8_M 3'b001
`define MF_AO_M 3'b010  
`define MF_WD_W 3'b011
`define MF_RD 3'b100  

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
`define j 6'b000010
