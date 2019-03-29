`include "ImmExtend.v"
`include "mux.v"
`include "ALU.v"

module Exec(Extop,ALUSrc,ALUctr,busA,busB,imm16,result);
	input Extop,ALUSrc;
	input[2:0] ALUctr;
	input[31:0] busA,busB;
	input[15:0] imm16;
	output[31:0] result;

	wire zero;
	wire[31:0] imm32,busC;

	ImmExtend ImmExtend_1(.Extop(Extop),.imm16(imm16),.y(imm32));
	Mux2_32 mux2_32_1(.d0(busB),.d1(imm32),.s(ALUSrc),.y(busC));
	ALU ALU_1(.a(busA),.b(busC),.ALUctr(ALUctr),.result(result),.zero(zero));

endmodule
