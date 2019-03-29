module EX(clk,rst,
			busA,busB,opcode,func,immi,rs,rt,rd,ALUc,RegDst,Extop,ALUSrc,MemWr,MemtoReg,MEMResult,WRresult,ForwardA,ForwardB,
			zero,result,rw);

input clk,rst;
input [31:0] busA,busB,MEMResult,WRresult;
input [5:0] opcode,func;
input [15:0] immi;
input [4:0] rs,rt,rd;
input [2:0] ALUc;
input [1:0] ForwardA,ForwardB;
input RegDst,Extop,ALUSrc,MemWr,MemtoReg;
output zero;
output [31:0] result;
output [4:0] rw;
ExecUnit exec(busA,busB,immi,Extop,ALUSrc,ALUc,zero,result,MEMResult,WRresult,ForwardA,ForwardB);
assign rw = RegDst ? rt : rd ;
endmodule

module ExecUnit(busA,busB,immi,Extop,ALUSrc,ALUc,zero,result,MEMResult,WRresult,ForwardA,ForwardB);

input[31:0] busA,busB,MEMResult,WRresult;
input[15:0] immi;
input Extop,ALUSrc;
input[2:0] ALUc;
input [1:0] ForwardA,ForwardB;
output zero;
output[31:0] result;
wire[31:0] extImmi,inputA,inputB;
SignExt signext(immi,extImmi);
mux3 busAToALU(busA,WRresult,MEMResult,ForwardA,inputA);
mux4 busBToALU(busB,WRresult,MEMResult,extImmi,ForwardB,inputB);
ALU FinALU(inputA,inputB,ALUc,zero,result);

endmodule

