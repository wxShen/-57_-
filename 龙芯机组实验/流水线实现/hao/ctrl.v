module ctrl(op,opcode,func,immi,rs,rt,rd,ALUc,regwr,regdst,branch,jump,extop,alusrc,memwr,memtoreg);

input [31:0] op;
output [5:0] opcode,func;
output [15:0] immi;
output [4:0] rs,rt,rd;
output [2:0] ALUc;
output regwr,regdst,branch,jump,extop,alusrc,memwr,memtoreg;
assign opcode = op[31:26];
assign func = op[5:0];
assign immi = op[15:0];
assign rs = op[25:21];
assign rt = op[20:16];
assign rd = op[15:11];
assign regwr = !op[31]&!op[30]&!op[29]&!op[28]&!op[27]&!op[26]
	|!op[31]&!op[30]&op[29]&op[28]&!op[27]&op[26]
	|!op[31]&!op[30]&op[29]&!op[28]&!op[27]&op[26]
	|op[31]&!op[30]&!op[29]&!op[28]&op[27]&op[26];
assign regdst = (!op[31]&!op[30]&!op[29]&!op[28]&!op[27]&!op[26])? 0 : 1;
assign branch = !op[31]&!op[30]&!op[29]&op[28]&!op[27]&!op[26];
assign jump = !op[31]&!op[30]&!op[29]&!op[28]&op[27]&!op[26];
ALUctr ALUCTR(op[31:26],func,ALUc);
assign extop = !(!op[31]&!op[30]&op[29]&op[28]&!op[27]&op[26]);
assign alusrc= !(!op[31]&!op[30]&!op[29]&!op[28]&!op[27]&!op[26]|!op[31]&!op[30]&!op[29]&op[28]&!op[27]&!op[26]);
assign memwr = op[31]&!op[30]&op[29]&!op[28]&op[27]&op[26];
assign memtoreg = op[31]&!op[30]&!op[29]&!op[28]&op[27]&op[26];

endmodule
