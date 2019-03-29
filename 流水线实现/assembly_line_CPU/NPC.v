//对下一条指令的计算
module NPC (
	input [15:0] imm16,    // 立即数
	input Branch,Zero,Jump, // 跳转指令，以及zero信号
	input [31:0] pc,  //当前pc的值
	input [25:0] Target,
	output [31:0] npc 
);

wire [31:0] pc_branch;
wire [31:0] Npc1,Npc2;
wire temp;
wire [1:0] jump_branch;

assign temp = Zero & Branch;
//对于立即数进行符号扩展，再右移两位
assign pc_branch = pc + {{14{imm16[15]}},imm16,2'b00};//分支指令
assign Npc2 = {pc[31:28],Target[25:0],2'b00};//跳转指令
assign jump_branch = {Jump,temp};
/*
Mux_2_To_1_Width #32 Mux (.i_Select(temp),.i_Data1 (pc),
 						   .i_Data2 (pc_branch),.o_Data  (Npc1));
Mux_2_To_1_Width #32 MUxJump(.i_Select(Jump),.i_Data1 (Npc1),
							.i_Data2 (Npc2),.o_Data  (npc));
*/							
Mux_4_To_1 #32 mux_jump_branch(.i_Select(jump_branch),.i_Data1 (pc),.i_Data2 (pc_branch),.i_Data3 (Npc2),.i_Data4 (0),.o_Data  (npc));
endmodule