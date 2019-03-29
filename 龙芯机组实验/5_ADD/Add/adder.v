`timescale 1ns / 1ps
//*************************************************************************
//   > �ļ���: adder.v
//   > ����  ���ӷ�����ֱ��ʹ��"+"�����Զ����ÿ���ļӷ���
//   > ����  : LOONGSON
//   > ����  : 2016-04-14
//*************************************************************************
module adder(
    input  [31:0] operand1,
    input  [31:0] operand2,
	 input  [31:0] operand3,
	 input  [31:0] operand4,
	 input  [31:0] operand5,
    input         cin,
    output [31:0] result,
    output        cout
    );
    assign {cout,result} = operand1 + operand2 + operand3 + operand4 + operand5 +cin;

endmodule
