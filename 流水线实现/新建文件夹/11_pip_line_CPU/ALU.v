//加法器的实现(有一个加法器，三个数据选择器，扩展器，或门阵列，异或门阵列，alu操作控制信号组成)
module ALU #(parameter WIDTH=32) (ALUctr,A,B,Result,Zero,Overflow);
	input [2:0] ALUctr;
	input [WIDTH-1:0] A;
	input [WIDTH-1:0] B;
	output Zero,Overflow;
	output [WIDTH-1:0] Result;
	//控制信号的定义
 	wire SUBctr,OVctr,SIGctr;
 	wire [1:0] Opctr;
 	//运算过程需要的变量
 	wire [WIDTH-1 : 0] ext_subctr, OR_result,Xor_result,less_result,add_result;
 	wire less,add_carry,add_sign;

 	//对于基本的alu运算的alu控制信号的产生（对ALUctr信号进行的三位编码对应课本的11条指令的实现）
 	assign SUBctr = ALUctr[2];
 	assign OVctr = ! ALUctr[1] & ALUctr[0];
 	assign SIGctr = ALUctr[0];
 	assign Opctr[1] = ALUctr[2] & ALUctr[1];
 	assign Opctr[0] = !ALUctr[2] & ALUctr[1] & !ALUctr[0];

 	assign OR_result = A | B;
 	Sign_Ext #1 sign_ext(.in(SUBctr),.out(ext_subctr));
 	assign Xor_result = B ^ ext_subctr;
 	Adder #32 Adder(.A(A),.B(Xor_result),.Cin(SUBctr),
 					.Result(add_result),.Cout(add_carry),.Zero(Zero),.Overflow(Overflow),.Sign(add_sign));
 	Mux_2_To_1 mux_less(.i_Select(SIGctr),.i_Data1 (SUBctr ^ add_carry),
 							.i_Data2 (Overflow ^ add_sign),.o_Data  (less));
	Mux_2_To_1_Width #32 mux_re(.i_Select(less),.i_Data1(32'h0000_0000),.i_Data2(32'h0000_0001),.o_Data(less_result));
	Mux_4_To_1 #32 mux_result(.i_Select(Opctr),.i_Data1(add_result),.i_Data2 (OR_result),
							.i_Data3 (less_result),.i_Data4 (32'hxxxx_xxxx),.o_Data  (Result));
endmodule

