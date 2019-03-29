module ID_Ex(clk,rst,imm16_in,busA_in,busB_in,Rs_in,Rt_in,Rd_in,imm16_out,busA_out,busB_out,Rs_out,Rt_out,Rd_out,Extop_in,ALUSrc_in,ALUctr_in,MemtoReg_in,RegWr_in,MemWr_in,RegDst_in,Extop_out,ALUSrc_out,ALUctr_out,MemtoReg_out,RegWr_out,MemWr_out,RegDst_out,if_ctrl);//在这个步骤消除控制冒险 故不传后PC+4和imm16
	input clk,rst,if_ctrl;
	input[15:0] imm16_in;
	input[31:0] busA_in,busB_in;
	input[4:0] Rt_in,Rd_in,Rs_in;
	input Extop_in,ALUSrc_in,MemtoReg_in,MemWr_in,RegWr_in,RegDst_in;
	input[2:0] ALUctr_in;
	output reg[15:0] imm16_out;
	output reg[31:0] busA_out,busB_out;
	output reg[4:0] Rt_out,Rd_out,Rs_out;
	output reg Extop_out,ALUSrc_out,MemtoReg_out,MemWr_out,RegWr_out,RegDst_out;
	output reg[2:0] ALUctr_out;

	initial begin
		imm16_out = 0;
		busA_out = 0;
		busB_out = 0;
		Rt_out = 0;
		Rd_out = 0;
		Rs_out = 0;
		Extop_out = 0;
		ALUSrc_out = 0;
		MemtoReg_out = 0;
		MemWr_out = 0;
		RegWr_out = 0;
		RegDst_out = 0;
		ALUctr_out = 0;
	end

	always @(negedge clk) begin
		if(rst | if_ctrl) begin
		imm16_out <= 0;
		busA_out <= 0;
		busB_out <= 0;
		Rt_out <= 0;
		Rd_out <= 0;
		Rs_out <= 0;
		Extop_out <= 0;
		ALUSrc_out <= 0;
		MemtoReg_out <= 0;
		MemWr_out <= 0;
		RegWr_out <= 0;
		RegDst_out <= 0;
		ALUctr_out <= 0;
		end
		else begin
		imm16_out <= imm16_in;
		busA_out <= busA_in;
		busB_out <= busB_in;
		Rt_out <= Rt_in;
		Rd_out <= Rd_in;
		Rs_out <= Rs_in;
		Extop_out <= Extop_in;
		ALUSrc_out <= ALUSrc_in;
		MemtoReg_out <= MemtoReg_in;
		MemWr_out <= MemWr_in;
		RegWr_out <= RegWr_in;
		RegDst_out <= RegDst_in;
		ALUctr_out <= ALUctr_in;
		end
	end

endmodule