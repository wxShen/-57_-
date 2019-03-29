module ExecUnit (ExtOp,Alusrc,Aluctr,BusA,BusB,imm16,zero,overflow,aluresult);
	input ExtOp,Alusrc;
	input [2:0] Aluctr;
	input [31:0] BusA,BusB;
	input [15:0] imm16;

	output zero,overflow;
	output [31:0] aluresult;

	wire[32:0] ext_imm,busb_result;
	ext #(16,32) Extimm(.Op(ExtOp),.in(imm16),.out(ext_imm));
	Mux_2_To_1_Width #32 mux_busb(.i_Select(ALUsrc),.i_Data1 (BusB),.i_Data2 (ext_imm),.o_Data  (busb_result));
	ALU #32 alu(.ALUctr(ALUctr),.A(BusA),.B(busb_result),.Result(aluresult),.Zero(zero),.Overflow(overflow));

endmodule