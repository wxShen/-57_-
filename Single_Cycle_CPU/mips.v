module mips (clk,rst);
	input clk,rst;
	wire [5:0] Op,Fuc;
	wire [2:0]ALUctr;
	wire Branch,Jump,RegDst,ALUSrc,MemtoReg,RegWr,MemWr;
	Ctrl ctrl(.Branch(Branch),.Jump(Jump),.RegDst(RegDst),.ALUsrc(ALUSrc),.ALUctr(ALUctr),
		.MemtoReg(MemtoReg),.RegWr(RegWr),.MemWr(MemWr),.ExtOp(ExtOp),.Op(Op),.Fuc(Fuc));
	Datapath datapath(.clk(clk),.rst(rst),.Branch(Branch),.Jump(Jump),.RegDst(RegDst),.ALUsrc(ALUSrc),.ALUctr(ALUctr),
		.MemtoReg(MemtoReg),.RegWr(RegWr),.MemWr(MemWr),.ExtOp(ExtOp),.Op(Op),.Fuc(Fuc));
endmodule