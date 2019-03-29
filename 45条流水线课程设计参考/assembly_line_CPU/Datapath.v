module Datapath(clk,rst);
	
	input clk,rst;

	//Ifetch(IF)取指令阶段
	wire[31:0] addr_in,addr_out,pc_plus_4,instruction,o_instruction;
	wire if_rst_2;
	//ID
	wire[31:0] address_2,busA_2,busB_2,busAnew_2,busBnew_2,n_addr_out;
	wire R_type,Branch_2,Jump_2,RegDst_2,ALUSrc_2,MemtoReg_2,RegWr_2,MemWr_2,Extop_2,loaduseHD_2,branchHD_2,if_stall,data_hazard;
	wire[1:0] ForwardA_2,ForwardB_2;
	wire[2:0] ALUctr_2;
	wire[4:0] Rs_2,Rt_2,Rd_2,shamt;
	wire[15:0] imm16_2;
	wire[25:0] target_2;
	wire[5:0] Op,Fuc;
	wire [5:0] i_EX_2; // i_EX = {Exop, alusrc, aluctr, regdst} =1+1+3+1 = 6
	wire [1:0] i_WB_2;  // WB = Memtoreg,RegWr;//2
	wire i_M_2; // M =Memwr

	//exe
	wire RegDst_3,ALUSrc_3,MemtoReg_3,RegWr_3,MemWr_3,Extop_3,zero_3,overflow_3;
	wire[1:0] ForwardA_3,ForwardB_3;
	wire[2:0] ALUctr_3;
	wire[15:0] imm16_3;
	wire[4:0] Rs_3,Rt_3,Rd_3,Rw_3;
	wire[31:0] busA_3,busB_3,result_3,busAnew_3,busBnew_3;
	wire [5:0] o_EX_2; // i_EX = {Exop, alusrc, aluctr, regdst} =1+1+3+1 = 6
	wire [1:0] o_WB_2,i_WB_3;  // WB = Memtoreg,RegWr;//2
	wire o_M_2,i_M_3; // M =Memwr

    //mem
    wire[31:0] result_4,busB_4,memory_4;
	wire[4:0] Rw_4;
	wire MemtoReg_4,RegWr_4,MemWr_4,overflow_4;
	wire[1:0] i_WB_4,o_WB_3;
	wire o_M_3;

	//wr
	wire RegWr_5,MemtoReg_5,overlow_5;
	wire[4:0] Rw_5;
	wire[31:0] busW_5,result_5,memory_5;
	wire[1:0] o_WB_4;
	
	//IF 
	PC pc(.clk(clk),.Reset(rst),.addr_in(addr_in),.addr_out(addr_out));
	IUnit iunit(.addr_in(addr_out),.instruction(instruction),.pc_plus_4(pc_plus_4));
	Mux_2_To_1_Width #32 mux_pc(.i_Select(data_hazard),.i_Data1 (pc_plus_4),.i_Data2 (n_addr_out),.o_Data(addr_in));
	IF_ID_reg IF_ID(.clk(clk),.rst(if_rst_2 | rst),.if_stall(if_stall),.i_pc_plus_4(pc_plus_4),.i_Instruction(instruction),.o_pc_plus_4(address_2),.o_Instruction(o_instruction));
	
	//Reg_Dec(ID)译码阶段
	assign i_EX_2 = {Extop_2,ALUSrc_2,ALUctr_2,RegDst_2};
	assign i_WB_2 = { MemtoReg_2,RegWr_2};
	assign i_M_2 = MemWr_2;
	Decode decode(.Instruction(o_instruction),.Op(Op),.Rs(Rs_2),.Rt(Rt_2),.Rd(Rd_2),.shamt(shamt),.Fuc(Fuc),.imm16(imm16_2),.Target(target_2));
	//Normal
	Ctrl ctrl(.Branch(Branch_2),.Jump(Jump_2),.RegDst(RegDst_2),.ALUsrc(ALUSrc_2),.ALUctr(ALUctr_2),.MemtoReg(MemtoReg_2),.RegWr(RegWr_2),.MemWr(MemWr_2),.ExtOp(Extop_2),.R_type(R_type),.Op(Op),.Fuc(Fuc));
	//assign Rw = RegDst ? Rd : Rb;//选择写入寄存器的多选器
	Regfile regfile(.clk(clk),.RegWr(RegWr_5),.Overflow(overflow_5),.Ra(Rs_2),.Rb(Rt_2),.Rw(Rw_5),.Busw(busW_5),.BusA(busA_2),.BusB(busB_2));
	//Forwarding
	Mux_4_To_1 #32 mux_1(.i_Select(ForwardA_2),.i_Data1 (busA_2),.i_Data2 (result_4),.i_Data3 (busW_5),.i_Data4 (0),.o_Data  (busAnew_2));
	Mux_4_To_1 #32 mux_2(.i_Select(ForwardB_2),.i_Data1 (busB_2),.i_Data2 (result_4),.i_Data3 (busW_5),.i_Data4 (0),.o_Data  (busBnew_2));
	FrowardingUnit forwarding(.Ex_Mem_RegWr(RegWr_4),.Mem_Wr_RegWr(RegWr_5),.ID_Ex_Rt(Rt_2),.ID_Ex_Rs(Rs_2),.Ex_Mem_Rd(Rw_4),.Mem_Wr_Rd(Rw_5),.ALUsrcA(ForwardA_2),.ALUsrcB(ForwardB_2));
	//Hazard Detection(对于branch指令的阻塞后对指令的转发)
	pipctrlHD_Unit pip(.Jump(Jump_2),.Branch(Branch_2),.addr_in(address_2),.imm16(imm16_2),.target(target_2),.BusA(busAnew_2),.BusB(busBnew_2),.addr_out(n_addr_out),.if_rst(if_rst_2),.if_stall(if_stall),.data_hazard(data_hazard),.ID_EX_MemtoReg(MemtoReg_3),.ID_Ex_Rt(Rw_3),.IF_ID_Rs(Rs_2),.IF_ID_Rt(Rt_2),.load_use(loaduseHD_2),.ID_EX_RegWr(RegWr_3),.Ex_Mem_MemtoReg(MemtoReg_4),.Ex_Mem_Rt(Rw_4),.branchHD(branchHD_2));
	ID_EX_reg ID_Ex(.clk(clk),.rst(if_stall | if_rst_2 | rst),.i_WB(i_WB_2),.i_M(i_M_2),.i_EX(i_EX_2),.i_Rs(Rs_2),.i_Rt(Rt_2),.i_imm16(imm16_2),.i_BusA(busA_2),.i_BusB(busB_2),.i_Rd(Rd_2),.o_WB(o_WB_2),.o_M(o_M_2),.o_EX(o_EX_2) ,.o_Rs(Rs_3),.o_Rt(Rt_3),.o_imm16(imm16_3),.o_BusA(busA_3),.o_BusB(busB_3),.o_Rd(Rd_3),.load_used(loaduseHD_2));

	//Exec(Ex)执行阶段
	assign {Extop_3,ALUSrc_3,ALUctr_3,RegDst_3} = o_EX_2;
	assign { MemtoReg_3,RegWr_3} = o_WB_2;
	assign MemWr_3 = o_M_2;
	assign i_WB_3 = o_WB_2;
	assign i_M_3 = o_M_2;
	Mux_4_To_1 #32 mux_3(.i_Select(ForwardA_3),.i_Data1 (busA_3),.i_Data2 (result_4),.i_Data3 (busW_5),.i_Data4 (0),.o_Data  (busAnew_3));
	Mux_4_To_1 #32 mux_4(.i_Select(ForwardB_3),.i_Data1 (busB_3),.i_Data2 (result_4),.i_Data3 (busW_5),.i_Data4 (0),.o_Data  (busBnew_3));
	FrowardingUnit Forwarding(.Ex_Mem_RegWr(RegWr_4),.Mem_Wr_RegWr(RegWr_5),.ID_Ex_Rt(Rt_3),.ID_Ex_Rs(Rs_3),.Ex_Mem_Rd(Rw_4),.Mem_Wr_Rd(Rw_5),.ALUsrcA(ForwardA_3),.ALUsrcB(ForwardB_3));
	ExecUnit exe(.ExtOp(Extop_3),.Alusrc(ALUSrc_3),.Aluctr(ALUctr_3),.BusA(busAnew_3),.BusB(busBnew_3),.imm16(imm16_3),.zero(zero_3),.overflow(overflow_3),.aluresult(result_3));
	Ex_Mem_reg Ex_Mem(.clk(clk),.rst(rst),.i_WB(i_WB_3),.i_M(i_M_3),.i_overflow(overflow_3),.i_result(result_3),.i_BusB(busBnew_3),.i_Rw(Rw_3),.o_WB(o_WB_3),.o_M(o_M_3),.o_overflow(overflow_4),.o_result(result_4),.o_BusB(busB_4),.o_Rw(Rw_4));
	Mux_2_To_1_Width #5 mux2_3(.i_Select(RegDst_3),.i_Data1 (Rt_3),.i_Data2 (Rd_3),.o_Data (Rw_3));

	//Mem访存阶段
	assign { MemtoReg_4,RegWr_4} = o_WB_3;
	assign MemWr_4 = o_M_3;
	assign i_WB_4 = o_WB_3;
	dm_4k dm(.addr(result_4[11:2]),.din(busB_4),.MemWr(MemWr_4),.clk(clk),.dout(memory_4));//数据存储器
	Mem_Wr_reg Mem_wr(.clk(clk),.rst(rst),.i_WB(i_WB_4),.i_overflow(overflow_4),.i_Dm(memory_4),.i_result(result_4),.i_Rw(Rw_4),.o_WB(o_WB_4),.o_overflow(overflow_5),.o_Dm(memory_5),.o_result(result_5),.o_Rw(Rw_5));
	
	//写回寄存器阶段
	assign { MemtoReg_5,RegWr_5} = o_WB_4;
	Mux_2_To_1_Width #32 Mux_result(.i_Select(MemtoReg_5),.i_Data1 (result_5),.i_Data2 (memory_5),.o_Data  (busW_5));	
endmodule // Datapath
