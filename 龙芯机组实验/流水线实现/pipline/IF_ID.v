module IF_ID(clk,rst,if_stall,PC_in,ins_in,PC_out,ins_out,if_ctrl);
	input clk,rst,if_stall;
	input[31:0] PC_in,ins_in;
	output reg[31:0] PC_out,ins_out;
	output reg if_ctrl;

	initial begin
		PC_out = 0;
		ins_out = 0;
		if_ctrl = 1;
	end

	always @(negedge clk) begin
		if(rst) begin
			PC_out <= 0;
			ins_out <= 0;
			if_ctrl <= 1;
		end
		else if(if_stall) begin
		end
		else begin
			PC_out <= PC_in;
			ins_out <= ins_in;
			if_ctrl <=0;
		end
	end
endmodule

