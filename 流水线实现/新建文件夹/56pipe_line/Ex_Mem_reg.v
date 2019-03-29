module Ex_Mem_reg (clk,rst,i_WB,i_M,i_overflow,i_lo_write,i_hi_write,i_result,i_BusB,i_Rw,i_lo_result,i_pc,
						   o_WB,o_M,o_overflow,o_lo_write,o_hi_write,o_result,o_BusB,o_Rw,o_lo_result,o_pc);

input clk,rst,i_lo_write,i_hi_write,i_overflow;    // Clock
input [16:0] i_WB;
input [4:0] i_Rw,i_M;
input [31:0] i_BusB,i_result,i_lo_result,i_pc;

output reg o_lo_write,o_hi_write,o_overflow;//可对branch指令提前预测因此（o_M(branch)）
output reg [16:0] o_WB;
output reg [4:0] o_Rw,o_M;
output reg [31:0] o_BusB,o_result,o_lo_result,o_pc;

reg [167:0] Ex_Mem_reg; //2+2+5+96 = 105 + 18 + 32 + 32; 3 + 16 +10 +128 =167

initial 
	begin
		Ex_Mem_reg <= 168'b0;
		o_result = 0;o_overflow =0;o_M =0;o_WB =0;o_Rw =0;o_BusB =0;o_Rw = 0;o_lo_result =0 ; o_pc =0;o_lo_write =0;o_hi_write=0;
	end
	
always @(*)
	begin
		Ex_Mem_reg <= {i_WB,i_M,i_overflow,i_lo_write,i_hi_write,i_result,i_BusB,i_Rw,i_lo_result,i_pc};
	end
always @(negedge clk)//每次总是在时钟下降沿读寄存器
	if(rst)
		begin
			//Ex_Mem_reg <= 187'b0;
			o_result = 0;o_overflow =0;o_M =0;o_WB =0;o_Rw =0;o_BusB =0 ; o_Rw = 0 ; o_lo_result =0 ;o_pc =0;o_lo_write =0;o_hi_write=0;
		end
	else
		begin
			{o_WB,o_M,o_overflow,o_lo_write,o_hi_write,o_result,o_BusB,o_Rw,o_lo_result,o_pc} <= Ex_Mem_reg;
		end
endmodule