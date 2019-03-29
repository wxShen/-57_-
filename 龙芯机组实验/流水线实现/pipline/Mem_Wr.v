module Mem_Wr(clk,rst,memory_in,result_in,Rw_in,memory_out,result_out,Rw_out,MemtoReg_in,RegWr_in,MemtoReg_out,RegWr_out);
	input clk,rst;
	input[31:0] memory_in,result_in;
	input[4:0] Rw_in;
	input MemtoReg_in,RegWr_in;
	output reg[31:0] memory_out,result_out;
	output reg[4:0] Rw_out;
	output reg MemtoReg_out,RegWr_out;

	initial begin
		memory_out = 0;
		result_out = 0;
		Rw_out = 0;
		MemtoReg_out = 0;
		RegWr_out = 0;
	end

	always @(negedge clk) begin
		if(rst) begin
		memory_out <= 0;
		result_out <= 0;
		Rw_out <= 0;
		MemtoReg_out <= 0;
		RegWr_out <= 0;
		end
		else begin
		memory_out <= memory_in;
		result_out <= result_in;
		Rw_out <= Rw_in;
		MemtoReg_out <= MemtoReg_in;
		RegWr_out <= RegWr_in;
		end
	end
endmodule
