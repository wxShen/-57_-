//单周期实现
module Datapath(clk,rst,Branch,Jump,RegDst,ALUsrc,ALUctr,MemtoReg,RegWr,MemWr,ExtOp,Op,Fuc);
	input clk,rst,Branch,Jump,RegDst,RegWr,ALUsrc,MemWr,MemtoReg,ExtOp;
	input [2:0] ALUctr;
	output [5:0] Op,Fuc;
	//reg(寄存器）型变量具有记忆功能,wire(总线型)型没有
	wire [4:0] Rs,Rt,Rd,shamt;//定义所有变量中的用到的变量
	wire [15:0] imm16;
	wire [25:0] Target;
	wire [31:0] Instruction;
	wire [31:0] pc,Npc;
	wire Zero,Overflow;
	wire [31:0] BusA,BusB,BusW,Ext_imm,Mem_Data,ALU_result,busb_result;
	wire [4:0] Ra,Rb,Rw;
	PC Pc(.Npc(Npc),.clk(clk),.Reset(rst),.pc(pc));
	im_4k IM(.addr(pc[11:2]),.dout(Instruction));	//取指令
	Decode decode(.Instruction(Instruction),.Op(Op),.Rs(Rs),.Rt(Rt),
		.Rd(Rd),.shamt(shamt),.Fuc(Fuc),.imm16(imm16),.Target(Target));
	//执行阶段
	assign Ra = Rs;
	assign Rb = Rt;
	Regfile regfile(.clk(clk),.RegWr(RegWr),.Overflow(Overflow),.RegDst(RegDst),.Ra(Ra),.Rb(Rb),
					.Rw(Rw),.Rd(Rd),.Busw(BusW),.BusA(BusA),.BusB(BusB));
	//Ext #32 extimm(.ExtOP(ExtOp),.in2(imm16),.out2(Ext_imm));
	ext #(16,32) extimm(.Op(ExtOp),.in(imm16),.out(Ext_imm));
	Mux_2_To_1_Width #32 mux_busb(.i_Select(ALUsrc),.i_Data1 (BusB),.i_Data2 (Ext_imm),.o_Data  (busb_result));
	ALU #32 alu(.ALUctr(ALUctr),.A(BusA),.B(busb_result),.Result(ALU_result),.Zero(Zero),.Overflow(Overflow));
	dm_4k Dm(.addr(ALU_result[11:2]),.din(BusB),.MemWr(MemWr),.clk(clk),.dout(Mem_Data));
	Mux_2_To_1_Width #32 Mux_result(.i_Select(MemtoReg),.i_Data1 (ALU_result),.i_Data2 (Mem_Data),.o_Data  (BusW));
	NPC npc(.imm16(imm16),.Branch(Branch),.Zero(Zero),.Jump(Jump),.pc(pc),.Target(Target),.npc(Npc));
endmodule