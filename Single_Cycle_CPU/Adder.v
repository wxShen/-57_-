//加法器的实现
module Adder #(parameter D_WIDTH = 32)( //组合；逻辑器件
	input [D_WIDTH-1:0] A,
	input [D_WIDTH-1:0] B,
	input Cin,
	output [D_WIDTH-1:0] Result,
	output Cout,
	output Zero,
	output Overflow,
	output Sign
);
	//wire q = A & B;
	//wire g = A ^ B;
	
	//assign Result = Cin ^ g;
	//assign Cout = Cin & g | q;
	assign {Cout,Result} = A + B + Cin;
	assign Zero = (Result != 0) ? 0 : 1;
	assign Overflow = ((A + B) > 32'b11111111_11111111_11111111_11111111) ? 1 : 0;//在计算机中直接通过OF = Cn^Cn-1
	assign Sign = Result[31];
/*
always @(A or B or cin)//注意assign中的运算是并行执行的
	begin
		Result = Cin ^ A ^ B;
		Cout = (A & Cin) | (B & Cin) | (A & B);
		Zero = (Result == 1) ? 0 : 1;
		Overflow = ((A + B) > 32'b11111111_11111111_11111111_11111111) ? 1 : 0;//在计算机中直接通过OF = Cn^Cn-1
		Sign = Result[31];
	end*/
endmodule