module Mem_Wr_reg (clk,rst,i_WB,i_overflow,i_Dm,i_lo_write,i_hi_write,i_result,i_lo_result,i_Rw,i_pc,o_WB,o_overflow,o_Dm,o_lo_write,o_hi_write,o_result,o_lo_result,o_Rw,o_pc);
	input clk,rst,i_overflow,i_lo_write,i_hi_write;
	input [16:0] i_WB;
	input [4:0] i_Rw;
	input [31:0] i_Dm,i_result,i_lo_result,i_pc;

	reg[152:0] Mem_Wr_reg; //3+16+5+128 =152;
	
	output reg o_overflow,o_lo_write,o_hi_write;
	output reg [16:0] o_WB;
	output reg [4:0] o_Rw;
	output reg [31:0] o_Dm,o_result,o_lo_result,o_pc;

	initial 
		begin
			Mem_Wr_reg <= 153'b0;
			o_overflow =0;o_WB =0;o_Rw =0;o_Dm =0;o_result =0;o_lo_result=0;o_pc=0;
		end

	always @(*)
		begin
			 Mem_Wr_reg <= {i_WB,i_overflow,i_Dm,i_lo_write,i_hi_write,i_result,i_lo_result,i_Rw,i_pc};
		end
	always @(negedge clk) 
		if(rst)
			begin
				//Mem_Wr_reg <= 72'b0; 
				o_overflow =0;o_WB =0;o_Rw =0;o_Dm =0;o_result =0;o_lo_result=0;o_pc=0;
			end
		else
			begin 
				 {o_WB,o_overflow,o_Dm,o_lo_write,o_hi_write,o_result,o_lo_result,o_Rw,o_pc} <= Mem_Wr_reg ;
			end
endmodule