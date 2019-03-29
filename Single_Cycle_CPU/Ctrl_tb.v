module Ctrl_tb ();
	reg [5:0] Op,Fuc;
	wire Branch,Jump,RegDst,ALUsrc,MemtoReg,RegWr,MemWr,ExtOp;
	wire [2:0] ALUctr;

initial begin
	Op = 6'b0;
	Fuc = 6'b0;
	#100;
end
	
	always # 100 Op =Op +1;
	always #100 Fuc = Op +1;
	Ctrl ctrl(Branch,Jump,RegDst,ALUsrc,ALUctr,MemtoReg,RegWr,MemWr,ExtOp,Op,Fuc);

endmodule