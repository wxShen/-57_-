module ID_EX(clk,rst,ctr_bubble,
		busA,busB,opcode,func,immi,rs,rt,rd,ALUc,RegDst,extop,ALUSrc,MemWr,MemtoReg,RegWr,
		busA2,busB2,opcode2,func2,immi2,rs2,rt2,rd2,ALUc2,RegDst2,extop2,ALUSrc2,MemWr2,MemtoReg2,RegWr2);
input clk,rst,ctr_bubble;
input [31:0] busA,busB;
input [5:0] opcode,func;
input [15:0] immi;
input [4:0] rs,rt,rd;
input [2:0] ALUc;
input RegDst,extop,ALUSrc,MemWr,MemtoReg,RegWr;
output reg[31:0] busA2,busB2;
output reg[5:0] opcode2,func2;
output reg[15:0] immi2;
output reg[4:0] rs2,rt2,rd2;
output reg[2:0] ALUc2;
output reg RegDst2,extop2,ALUSrc2,MemWr2,MemtoReg2,RegWr2;
	initial begin
		busA2 = 0;
		busB2 = 0;
		opcode2 = 0;
		func2 = 0;
		immi2 = 0;
		rs2 = 0;
		rt2 = 0;
		rd2 = 0;
		ALUc2 = 0;
		RegDst2 = 0;
		extop2 = 0;
		ALUSrc2 = 0;
		MemWr2 = 0;
		MemtoReg2 = 0;
		RegWr2 = 0 ;
	end

	always @(negedge clk) begin
		if (rst|ctr_bubble) begin
			busA2 <= 0;
			busB2 <= 0;
			opcode2 <= 0;
			func2 <= 0;
			immi2 <= 0;
			rs2 <= 0;
			rt2 <= 0;
			rd2 <= 0;
			ALUc2 <= 0;
			RegDst2 <= 0;
			extop2 <= 0;
			ALUSrc2 <= 0;
			MemWr2 <= 0;
			MemtoReg2 <= 0;
			RegWr2 <=0;
		end
		else begin
			busA2 <= busA;
			busB2 <= busB;
			opcode2 <= opcode;
			func2 <= func;
			immi2 <= immi;
			rs2 <= rs;
			rt2 <= rt;
			rd2 <= rd;
			ALUc2 <= ALUc;
			RegDst2 <= RegDst;
			extop2 <= extop;
			ALUSrc2 <= ALUSrc;
			MemWr2 <= MemWr;
			MemtoReg2 <= MemtoReg;
			RegWr2 <= RegWr;
		end
	end
endmodule
