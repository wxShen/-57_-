module Regfile (	
	input wire clk,//clock
	input wire RegWr,//wire enable
	input wire Overflow,
	input [4:0] Ra,Rb,Rw,//寄存器的编号 ra(rs),rb(rt),rw(rt|rd)
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
	
always @(negedge clk or (clk == 0)) //总是在时钟周期的前半个周期对寄存器文件进行写操作(解决结构冒险)
	begin
		if(RegWr & (!Overflow))
			begin
				RF[Rw] <= Busw;
			end
	end

/*always @(posedge clk or (clk == 1))//在时钟周期的后半段对寄存器文件进行读的操作
	begin
		if(Ra)
			begin
				BusA <= RF[Ra];
			end
		else
			begin
				BusA <= 0;
			end
	end

always @(posedge clkor (clk == 1))//在时钟周期的后半段对寄存器文件进行读的操作
	begin
		if(Rb)
			begin
				BusB <= RF[Rb];
			end
		else
			begin
				BusB <= 0;
			end
	end
*/	
assign BusA = (Ra != 0) ? RF[Ra] : 0;
assign BusB = (Rb != 0) ? RF[Rb] : 0;

endmodule