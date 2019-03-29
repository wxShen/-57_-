module Mem_Wr_reg (clk,rst,i_WB,i_overflow,i_Dm,i_result,i_Rw,o_WB,o_overflow,o_Dm,o_result,o_Rw);
	input clk,rst,i_overflow;
	input [1:0] i_WB;
	input [4:0] i_Rw;
	input [31:0] i_Dm,i_result;

	reg[71:0] Mem_Wr_reg; //1+2+5+64 =72;
	
	output reg o_overflow;
	output reg [1:0] o_WB;
	output reg [4:0] o_Rw;
	output reg [31:0] o_Dm,o_result;

	initial 
		begin
			Mem_Wr_reg <= 72'b0;
			o_overflow =0;o_WB =0;o_Rw =0;o_Dm =0;o_result =0;
		end

	always @(*)
		begin
			 Mem_Wr_reg <= {i_WB,i_overflow,i_Dm,i_result,i_Rw};
		end
	always @(negedge clk) 
		if(rst)
			begin
				Mem_Wr_reg <= 72'b0; 
			end
		else
			begin 
				 {o_WB,o_overflow,o_Dm,o_result,o_Rw} <= Mem_Wr_reg ;
			end
endmodule