module Regfile (	
	input wire clk,//clock
	input wire RegWr,//wire enable
	input wire Overflow,
	input RegDst,//控制将要写入寄存器的编号
	input [4:0] Ra,Rb,Rw,Rd,//寄存器的编号 ra(rs),rb(rt),rw(rt|rd)
	input [31:0] Busw,//写入寄存器的信号
	output [31:0] BusA,BusB
);
parameter zero =0;
parameter gp = 28;
parameter sp = 29;
parameter GPDEFAULT = 32'h0000_1800;
parameter SPDEFAULT = 32'h0000_2ffc;
 reg [31:0] RF [31:0];//32位的寄存器文件
 
integer i;
initial//初始化gp,sp指针（与always块的区别：无触发条件只在仿真零时刻执行一次，一般只用测设文件）
	begin
		for(i=0;i<32;i=i+1)
			RF[i] = 32'b0;	
		RF[zero] = 32'b0;
	    RF[gp] = GPDEFAULT; //初始化全局指针
	   	RF[sp] = SPDEFAULT; //初始化指针
	end

assign Rw = RegDst ? Rd : Rb;//选择写入寄存器的多选器

always @(posedge clk)
	begin
		if(RegWr & (!Overflow))
			begin
				RF[Rw] <= Busw;
			end
	end

assign BusA = (Ra != 0) ? RF[Ra] : 0;
assign BusB = (Rb != 0) ? RF[Rb] : 0;

endmodule