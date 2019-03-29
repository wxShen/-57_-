module Datapath(clk,rst);
	input clk,rst
	//Ifetch(IF)取指令阶段
	wire[31:0] addr_in,addr_out,instruction;
	wire[31:0] o_addr1,o_instruction1;
	wire if_stall_1;
	PC pc(.clk(clk),.Reset(rst),.addr_in(addr_in),.addr_out(addr_out));
	im_4k IM(.addr(addr_out[11:2]),.dout(instruction));	//取指令
	IF_ID_reg IF_ID(.clk(clk),.rst(rst),.if_stall(if_stall_1),.i_pc_plus_4(addr_out),.i_Instruction(instruction),
					.o_pc_plus_4(o_addr1),.o_instruction(o_instruction1));
	//Reg_Dec(ID)译码阶段
	wire[31:0] address_2,ins_2,busA_2,busB_2,busAnew_2,busBnew_2,PipCtrl_out;
	wire Overflow,R_type,Branch_2,Jump_2,RegDst_2,ALUSrc_2,MemtoReg_2,RegWr_2,MemWr_2,Extop_2,loaduseHD_2,branchHD_2,if_stall,data_hazard;
	wire[1:0] ForwardA_2,ForwardB_2;
	wire[2:0] ALUctr_2;
	wire[4:0] Rs_2,Rt_2,Rd_2;
	wire[15:0] imm16_2;
	wire[25:0] target_2;
	wire[5:0] Op,Fuc;
	wire [5:0] i_EX_2,o_EX_2; // i_EX = {Exop, alusrc, aluctr, regdst} =1+1+3+1 = 6
	wire [1:0] i_WB_2,o_WB_2;  // WB = Memtoreg,RegWr;//2
	wire i_M_2,o_M_2; // M =Memwr
	assign i_EX_2 = {Extop_2,ALUSrc_2,ALUctr_2,RegDst_2};
	assign i_WB_2 = { MemtoReg_2,RegWr_2};
	assign i_M_2 = MemWr_2;
	Decode decode(.Instruction(o_instruction1),.Op(Op),.Rs(Rs_2),.Rt(Rt_2),.Rd(Rd_2),.shamt(shamt),.Fuc(Fuc),.imm16(imm16_2),.Target(target_2));
	//Hazard Detection(对于branch指令的阻塞后对指令的转发)
	//Forwarding
	Mux_4_To_1 #32 mux_1(.i_Select(ForwardA_2),.i_Data1 (busA_2),.i_Data2 (result_4),.i_Data3 (busW_5),.i_Data4 (0),.o_Data  (busAnew_2));
	Mux_4_To_1 #32 mux_2(.i_Select(ForwardB_2),.i_Data1 (busB_2),.i_Data2 (result_4),.i_Data3 (busW_5),.i_Data4 (0),.o_Data  (busBnew_2));
	FrowardingUnit forwarding(.Ex_Mem_RegWr(RegWr_3),.Mem_Wr_RegWr(RegWr_4),.ID_Ex_Rt(Rt_2),.ID_Ex_Rs(Rs_2),
						.Ex_Mem_Rd(Rw_4),.Mem_Wr_Rd(Rw_5),.ALUsrcA(ForwardB_2),.ALUsrcB(ForwardB_2));
	pipctrlHD_Unit (.Jump(Jump_2),.Branch(Branch_2),.addr_in(address_2),.imm16(imm16_2),.target(target_2),.BusA(busAnew_2),.BusB(busBnew_2),
		.addr_out(PipCtrl_out),.if_rst(if_rst_2),.if_stall(if_stall),.data_hazard(if_change1),.ID_EX_MemtoReg(MemtoReg_3),.ID_Ex_Rt(Rw_3),
		.IF_ID_Rs(Rs_2),.IF_ID_Rt(Rt_2),.load_use(loaduseHD_2),.ID_EX_RegWr(RegWr_3),.Ex_Mem_MemtoReg(MemtoReg_4),.Ex_Mem_Rt(Rw_4),.branchHD(branchHD_2));
	//Normal
	Ctrl ctrl(.Branch(Branch_2),.Jump(Jump_2),.RegDst(RegDst_2),.ALUsrc(ALUSrc_2),.ALUctr(ALUctr_2),
		.MemtoReg(MemtoReg_2),.RegWr(RegWr_2),.MemWr(MemWr_2),.ExtOp(Extop_2),.R_type(R_type),.Op(Op),.Fuc(Fuc));
	//assign Rw = RegDst ? Rd : Rb;//选择写入寄存器的多选器
	Regfile regfile(.clk(clk),.RegWr(RegWr_5),.Overflow(Overflow),.Ra(Rs_2),.Rb(Rt_2),.Rw(Rw_5),.Busw(busW_5),.BusA(busA_2),.BusB(busB_2));
	ID_Ex ID_Ex_1(.clk(clk),.rst(if_stall),.imm16_in(imm16_2),.busA_in(busA_2),.busB_in(busB_2),.Rs_in(Rs_2),.Rt_in(Rt_2),.Rd_in(Rd_2),.imm16_out(imm16_3),.busA_out(busA_3),.busB_out(busB_3),
		.Rs_out(Rs_3),.Rt_out(Rt_3),.Rd_out(Rd_3),.Extop_in(Extop_2),.ALUSrc_in(ALUSrc_2),.ALUctr_in(ALUctr_2),.MemtoReg_in(MemtoReg_2),.RegWr_in(RegWr_2),.MemWr_in(MemWr_2),.RegDst_in(RegDst_2),
		.Extop_out(Extop_3),.ALUSrc_out(ALUSrc_3),.ALUctr_out(ALUctr_3),.MemtoReg_out(MemtoReg_3),.RegWr_out(RegWr_3),.MemWr_out(MemWr_3),.RegDst_out(RegDst_3),.if_ctrl(if_ctrl));//signal 'rst' useless right now
	ID_EX_reg ID_Ex_1(.clk(clk),.rst(rst),.i_WB(i_WB_2),.i_M,i_EX,i_Rs,i_Rt,i_imm16,i_BusA,i_BusB,i_Rd,i_func,o_WB,o_M,o_EX ,o_Rs,o_Rt,o_imm16,o_BusA,o_BusB,o_Rd,o_func,load_used);
	//Exec(Ex)执行阶段
	wire RegDst_3,ALUSrc_3,MemtoReg_3,RegWr_3,MemWr_3,Extop_3;
	wire[1:0] ForwardA_3,ForwardB_3;
	wire[2:0] ALUctr_3;
	wire[15:0] imm16_3;
	wire[4:0] Rs_3,Rt_3,Rd_3,Rw_3;
	wire[31:0] busA_3,busB_3,result_3,busAnew_3,busBnew_3;
	wire[1:0] i_WB_3;
	wire[5:0] i_EX_3;
	wire i_M_3;
	assign i_WB_3 = {MemtoReg_3,RegWr_3};
	Mux_4_To_1 #32 mux_1(.i_Select(ForwardA_3),.i_Data1 (busA_3),.i_Data2 (result_4),.i_Data3 (busW_5),.i_Data4 (0),.o_Data  (busAnew_2));
	Mux_4_To_1 #32 mux_2(.i_Select(ForwardB_3),.i_Data1 (busB_3),.i_Data2 (result_4),.i_Data3 (busW_5),.i_Data4 (0),.o_Data  (busBnew_2));
	FrowardingUnit forwarding(.Ex_Mem_RegWr(RegWr_4),.Mem_Wr_RegWr(RegWr_5),.ID_Ex_Rt(Rt_2),.ID_Ex_Rs(Rs_2),
						.Ex_Mem_Rd(Rw_4),.Mem_Wr_Rd(Rw_5),.ALUsrcA(ForwardB_2),.ALUsrcB(ForwardB_2));
	ExecUnit exe(ExtOp,Alusrc,Aluctr,BusA,BusB,imm16,zero,overflow,aluresult);
	Ex_Mem_reg ex_mem_reg(.clk(clk),.rst(rst),.i_WB(i_WB_3),.i_M(RegWr_3),i_zero,i_overflow,i_result,i_BusB,i_Rw,o_WB,o_M,o_zero,o_overflow,o_result,o_BusB,o_Rw);

	//Mem访存阶段
	wire[31:0] result_4,busB_4,memory_4;
	wire[4:0] Rw_4;
	wire MemtoReg_4,RegWr_4,MemWr_4;
	wire [1:0] i_WB_4;
	wire i_M_4;
	dm_4k dm(.addr(),.din,.MemWr,.clk(clk),.dout(memory_4));//数据存储器
	Mem_Wr_reg mem_wr_reg(clk,rst,i_WB,i_overflow,i_Dm,i_result,i_Rw,o_WB,o_overflow,o_Dm,o_result,o_Rw);
	//写回寄存器阶段
	wire RegWr_5,MemtoReg_5;
	wire[4:0] Rw_5;
	wire[31:0] busW_5,result_5,memory_5;
	Mux_2_To_1_Width #32 Mux_result(.i_Select(MemtoReg_5),.i_Data1 (result_5),.i_Data2 (memory_5),.o_Data  (busW_5);	
endmodule // Datapath
