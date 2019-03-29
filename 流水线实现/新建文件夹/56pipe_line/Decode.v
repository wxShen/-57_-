module Decode (Instruction,Op,Rs,Rt,Rd,shamt,func,imm16,Target,cp0r_sel);//值得注意的是在取指令是Branch,Jump；
	input [31:0] Instruction;
	output [31:26] Op;
	output [25:21] Rs;
	output [20:16] Rt;
	output [15:11] Rd;
	output [10:6] shamt;
	output [5:0] func;
	output [15:0] imm16;// // 地址偏移量或者在ALU中计算是用到的立即数
	output [25:0] Target;
	output[2:0] cp0r_sel;

	assign Op = Instruction[31:26];
	assign Rs = Instruction[25:21];
	assign Rt = Instruction[20:16];
	assign Rd = Instruction[15:11];
	assign shamt = Instruction[10:6];// 特殊域，可能存放偏移量(一般对于移位指令能够用到)
	assign func = Instruction[5:0];
	assign imm16 = Instruction[15:0];
	assign Target = Instruction[25:0];
	assign cp0r_sel= Instruction[2:0];   // cp0寄存器的select域
endmodule