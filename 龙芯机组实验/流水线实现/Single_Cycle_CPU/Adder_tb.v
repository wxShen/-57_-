`timescale 1ns / 1ps
module Adder_tb ();
	reg [31:0] A,B;
	reg Cin;
	wire[31:0] Result;
	wire Cout,Zero,Overflow,Sign;

	initial 
	begin
		A = 32'b0;
		B = 32'b0;
		Cin = 0;
		#100;
	end

	always #100 A = A +1 ;  //$random;
	always #100 B =  B + 1;  //$random为系统任务，产生一个随机的32位数
    always #100 Cin = 1;//加了拼接符，{$random}产生一个非负数，除2取余得到0或1

	Adder #32 add(.A(A),.B(B),.Cin(Cin),.Result(Result),.Cout(Cout),.Zero(Zero),.Overflow(Overflow),.Sign(Sign));
endmodule