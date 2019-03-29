module Ex_Mem_reg (clk,rst,i_WB,i_M,i_zero,i_overflow,i_result,i_BusB,i_Rw
							o_WB,o_M,o_zero,o_overflow,o_result,o_BusB,o_Rw);

input clk,rst,i_zero,i_overflow,i_M;    // Clock
input [1:0] i_WB;
input [4:0] i_Rw;
input [31:0] i_BusB,i_result;

output reg o_zero,o_overflow,o_M;//可对branch指令提前预测因此（o_M(branch)）
output reg [1:0] o_WB;
output reg [4:0] o_Rw;
output reg [31:0] o_BusB,o_result;

reg [106:0] Ex_Mem_reg; //3+2+5+96 = 106;

initial 
	begin
		Ex_Mem_reg <= 106'b0;
	end
	
always @(*)
	begin
		{i_WB,i_M,i_zero,i_overflow,i_result,i_BusB,i_Rw} <= Ex_Mem_reg;
	end
always @(negedge clk)//每次总是在时钟下降沿写入寄存器
	if(rst)
		begin
			Ex_Mem_reg <= 106'b0;
		end
	else
		begin
			Ex_Mem_reg <= {i_WB,i_M,i_zero,i_overflow,i_result,i_BusB,i_Rw};
		end
endmodule