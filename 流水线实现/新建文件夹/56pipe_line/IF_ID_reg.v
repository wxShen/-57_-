//IF_ID_reg 是对PC取的指令以及对PC+4的寄存
module IF_ID_reg (clk,rst,if_stall,i_pc_plus_4,i_Instruction,o_pc_plus_4,o_Instruction);
	input clk,rst,if_stall;//if_stall(load_use)
	input [31:0] i_pc_plus_4;
	input [31:0] i_Instruction;
	
	output reg [31:0] o_pc_plus_4;
	output reg [31:0] o_Instruction;
	reg [63:0] IF_ID_reg; //32+32 =64
	initial
		begin
			IF_ID_reg = 64'b0;o_pc_plus_4 = 32'h3000;o_Instruction =32'b0;
		end

	always @(*)
		begin
	 	  IF_ID_reg <= {i_pc_plus_4,i_Instruction};
		end

	always @(negedge clk )begin
		if(if_stall)
			begin
				 //当处于load_used时注意对寄存器内容的保持
			end
		else if(rst)//对于branch 加数据冒险时对该寄存器的flush
		begin
				//IF_ID_reg <= 64'b0;
				o_pc_plus_4 = 32'h3000;
				o_Instruction =32'b0;
			end
		else 
			begin
				{o_pc_plus_4,o_Instruction} <= IF_ID_reg;
			end
	end
endmodule