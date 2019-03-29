//对下一条指令的计算
module NPC (
	input [15:0] imm16,    // 立即数
	input [7:0] Branch,//Branch <= {beq,bne,bgez,bgtz,blez,bltz,bgezal,bltzal} ,Jump <= {j,jal,jr,jalr};
	input [3:0] Jump, // 跳转指令，以及zero信号
	input [31:0] pc,  //当前pc的值
	input [31:0] busA,//rs寄存器的值
	input [31:0] busB,
    input [4:0] Rd,
	input [25:0] Target,
	output [31:0] newbusA,newbusB,//对于branch链接和跳转链接指令需要对 PC 加 运算并写入寄存器（默认ra）
	output [31:0] npc,
    output [4:0] newRd
);

 //无条件跳转
    wire        j_taken;
    wire [31:0] j_target;
    assign j_taken = (|Jump);//看是否有跳转指令发生
    //寄存器跳转地址为rs_value,其他跳转为{bd_pc[31:28],target,2'b00}
    assign j_target = (Jump[1] | Jump[0]) ? busA : {pc[31:28],Target,2'b00};
    wire jbr_al;
    assign jbr_al = Branch[1] | Branch[0] | Jump[2] | Jump[0];
    assign newbusA= (jbr_al) ? pc    : busA;
    assign newbusB= (jbr_al) ? 32'd4 : busB;
    assign newRd  = (jbr_al) ? 5'b11111 : Rd;
    //branch指令
    wire br_taken;//对于bgezal,bltzal还需要对将 pc+8 写到31号寄存器中
    wire[31:0] br_target;
    assign br_taken = (|Branch);
    // 分支跳转目标地址：PC=PC+offset<<2
    assign br_target[31:2] = pc[31:2] + {{14{imm16[15]}}, imm16};  
    assign br_target[1:0]  = pc[1:0];
	wire [1:0] jump_branch;
    assign jump_branch = {j_taken,br_taken};
    
    Mux_4_To_1 #32 mux_jump_branch(.i_Select(jump_branch),.i_Data1 (pc),.i_Data2 (br_target),.i_Data3 (j_target),.i_Data4 (0),.o_Data (npc));
endmodule