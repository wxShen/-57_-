//值得注意的是在取指令是Branch,Jump；
module Decode (Instruction,Op,Rs,Rt,Rd,shamt,Fuc,imm16,Target);
	input [31:0] Instruction;
	output [31:26] Op;
	output [25:21] Rs;
	output [20:16] Rt;
	output [15:11] Rd;
	output [10:6] shamt;
	output [5:0] Fuc;
	output [15:0] imm16;
	output [25:0] Target;

	assign Op = Instruction[31:26];
	assign Rs = Instruction[25:21];
	assign Rt = Instruction[20:16];
	assign Rd = Instruction[15:11];
	assign shamt = Instruction[10:6];
	assign Fuc = Instruction[5:0];
	assign imm16 = Instruction[15:0];
	assign Target = Instruction[25:0];
	/*
	if(Op == 6'b000000)//R型指令
		begin
			assign Rs = Instruction[25:21];
			assign Rt = Instruction[20:16];
			assign Rd = Instruction[15:11];
			assign shamt = Instruction[10:6];
			assign Func = Instruction[5:0];
			assign imm16 = 16'bx;//为不定值
			assign Target = 26'bx;
		end
	else if(Op == 6'b000010 | 6'b000011)//I型指令
		begin
			assign Rs = Instruction[25:21];
			assign Rt = Instruction[20:16];
			assign Rd = 5'bx;
			assign shamt = 5'bx;
			assign Func = 6'bx;
			assign imm16 = Instruction[15:0];//为不定值
			assign Target = 26'bx;
		end
	else
		begin
			assign Rs = 5'bx;
			assign Rt = 5'bx;
			assign Rd = 5'bx;
			assign shamt = 5'bx;
			assign Func = 6'bx;
			assign imm16 = 16'bx;//为不定值
			assign Target = Instruction[25:0];
		end
		*/
endmodule