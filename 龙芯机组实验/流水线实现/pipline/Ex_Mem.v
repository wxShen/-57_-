module Ex_Mem(clk,rst,result_in,busB_in,Rw_in,result_out,busB_out,Rw_out,MemtoReg_in,RegWr_in,MemWr_in,MemtoReg_out,RegWr_out,MemWr_out);
	input clk,rst;
	input[31:0] result_in,busB_in;
	input[4:0] Rw_in;
	input MemtoReg_in,RegWr_in,MemWr_in;
	output reg[31:0] result_out,busB_out;
	output reg[4:0] Rw_out;
	output reg MemtoReg_out,RegWr_out,MemWr_out;

	initial begin
		result_out = 0;
		busB_out = 0;
		Rw_out = 0;
		MemtoReg_out = 0;
		RegWr_out = 0;
		MemWr_out = 0;
	end

	always @(negedge clk) begin
		if(rst) begin
		result_out <= 0;
		busB_out <= 0;
		Rw_out <= 0;
		MemtoReg_out <= 0;
		RegWr_out <= 0;
		MemWr_out <= 0;
		end
		else begin
		result_out <= result_in;
		busB_out <= busB_in;
		Rw_out <= Rw_in;
		MemtoReg_out <= MemtoReg_in;
		RegWr_out <= RegWr_in;
		MemWr_out <= MemWr_in;
		end
	end
endmodule