module datapath(clk,rst);

input clk,rst;
wire[31:0] din,dout;
wire [31:0] instr,extImmi,busA,busB,busW,inputB,result1,result2;
wire [5:0] opcode,func;
wire [15:0] immi;
wire [4:0] rs,rt,rd,rw;
wire [2:0] ALUc;
wire RegWr,RegDst,branch,jump,extop,alusrc,MemWr,MemtoReg,zero;
PC pc(clk,rst,din,dout);
NPC npc(instr,immi,branch,jump,zero,dout,din);
im_4k im(dout[11:2],instr);
assign rw = RegDst ? rt : rd ;
ctrl CTRL(instr,opcode,func,immi,rs,rt,rd,ALUc,RegWr,RegDst,branch,jump,extop,alusrc,MemWr,MemtoReg);
regfile regf(clk,RegWr,rs,rt,rw,busW,busA,busB);
SignExt sge(immi,extImmi);
mux2 regToALU(busB,extImmi,alusrc,inputB);
ALU FinALU(.a(busA),.b(inputB),.op(ALUc),.zero(zero),.result(result1));
dm_4k dm(result1[11:2],busB, MemWr, clk, result2);
mux2 ALUToreg(.d0(result1),.d1(result2),.s(MemtoReg),.y(busW));

endmodule
