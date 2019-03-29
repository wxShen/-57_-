module Regfile_tb ();

	reg clk, RegWr, Overflow,RegDst;//控制将要写入寄存器的编号
	reg [4:0] Ra,Rb,Rw,Rd;//寄存器的编号 ra(rs),rb(rt),rw(rt|rd)
	reg [31:0] Busw;//写入寄存器的信号
	wire [31:0] BusA,BusB;

initial begin
	clk =0;
	RegWr =0;
	Overflow =0;
	RegDst =0;
	Ra =0;
	Rb=0;
	Rd =0;
	Rw =0;
	Busw =0;
	#100;
end

always #100 clk = ~clk;
always #100 RegWr = ~RegWr;
always #200 Overflow =~Overflow;
always #300 RegDst = ~ RegDst;

Regfile regfile(clk,RegWr,Overflow,RegDst,Ra,Rb,Rw,Rd,Busw,BusA,BusB);
endmodule