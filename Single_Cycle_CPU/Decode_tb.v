module Decode_tb ();
	reg [31:0] Instruction;
	wire [31:26] Op;
	wire [25:21] Rs;
	wire [20:16] Rt;
	wire [15:11] Rd;
	wire [10:6] shamt;
	wire [5:0] Fuc;
	wire [15:0] imm16;
	wire [25:0] Target;

	initial begin
		Instruction = 6'h24090005;
	end
	Decode decode(Instruction,Op,Rs,Rt,Rd,shamt,Fuc,imm16,Target);

endmodule