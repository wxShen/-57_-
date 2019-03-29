
module ImmExtend(Extop,imm16,y);
	input Extop;
	input[15:0] imm16;
	output reg[31:0] y;

	always @(Extop or imm16) begin
		y[15:0] = imm16;
		y[31:16] = Extop?(imm16[15]?16'b1:16'b0):16'b0;
	end

endmodule
