module ID(clk,rst,din,
			instr,Rw,Di,
			busA,busB,opcode,func,immi,rs,rt,rd,ALUc,RegWr,RegDst,extop,ALUSrc,MemWr,MemtoReg,
			instr_jump,instr_branch,ctr_branch,jump,WR_RegWr,
			EX_MemtoReg,Mem_MemtoReg,EX_rt,EX_result,EX_rw,ENwr,ctr_bubble);
input clk,EX_MemtoReg,Mem_MemtoReg,WR_RegWr;
input[31:0] din,instr,Rw;
input [4:0] Di,EX_rt,EX_rw;
output [31:0] busA,busB,instr_jump,instr_branch,EX_result; 
output [5:0] opcode,func;
output [15:0] immi;
output [4:0] rs,rt,rd;
output [2:0] ALUc;
output rst,RegWr,RegDst,extop,ALUSrc,MemWr,MemtoReg,ctr_bubble;
output ctr_branch,jump,ENwr;
wire branch,jump;
wire [31:0] temp_busA,temp_busB;
assign zeroInstr = 32'b0;
ctrl CTRL(instr,opcode,func,immi,rs,rt,rd,ALUc,RegWr,RegDst,branch,jump,extop,ALUSrc,MemWr,MemtoReg);
regfile Reg(clk,WR_RegWr,rs,rt,Di,Rw,busA,busB);
assign instr_jump = {din[31:28],instr[25:0],2'b00};
assign instr_branch = din + {{14{immi[15]}}, immi, 2'b00};
assign temp_busA = (EX_rw == rs) ? EX_result : busA;
assign temp_busB = (EX_rw == rt) ? EX_result : busB;
assign ctr_branch = (!(temp_busA ^ temp_busB)) & branch;
pipeCtrl pipe(EX_MemtoReg,Mem_MemtoReg,EX_rt,rs,rt,instr,ctr_branch,jump,ENwr,ctr_bubble,rst);
endmodule
