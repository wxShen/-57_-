module Datapath(clk,rst);
	
	input clk,rst;

	//Ifetch(IF)取指令阶段
	wire[31:0] addr_in,addr_out,jbl_addr_in,pc_plus_4,instruction,o_instruction;
	wire [31:0] exc_pc;
	wire exc_vaild;
	//ID
	wire [31:0] address_2,busA_2,busB_2,busAnew_2,busBnew_2,n_addr_out,newbusA_2,JbrnewbusA,JbrnewbusB;
	wire mult_2,multu_2,div_2,divu_2,mthi_2,mtlo_2,mtc0_2e,RegDst_2,ALUSrc_2,MemtoReg_2,RegWr_2,Extop_2,loaduseHD_2,branchHD_2,if_stall,data_hazard;
	wire mfhi_2,mflo_2,mfc0_2,mtc0_2w,syscall_2,Break_2,eret_2,inst_load_2,inst_store_2,lb_sign_2;
	wire [1:0] ls_word_2;
	wire [7:0] Branch_2,cp0r_addr_2;
	wire [3:0] Jump_2;
	wire [1:0] ForwardA_2,ForwardB_2;
	wire [3:0] ALUctr_2;
	wire [4:0] Rs_2,Rt_2,Rd_2,shamt,jbrnewRd;
	wire [15:0] imm16_2;
	wire [25:0] target_2;
	wire [2:0] cp0r_sel_2;
	wire [5:0] Op,func;
	wire [13:0] i_EX_2; // i_EX = {Exop, alusrc, aluctr, regdst} =1+1+3+1 = 6
	wire [16:0] i_WB_2;  // WB = Memtoreg,RegWr;//2
	wire [4:0] i_M_2; // M =Memwr
	wire [31:0] ID_pc;
	//exe
	wire mult_3,multu_3,div_3,divu_3,mthi_3,mtlo_3,mtc0_3e,mtc0_3w,RegDst_3,ALUSrc_3,MemtoReg_3,RegWr_3,Extop_3,overflow_3,mfhi_3,mflo_3,mfc0_3,syscall_3,Break_3,eret_3;
	wire inst_load_3,inst_store_3,lb_sign_3,hi_write_3,lo_write_3;
	wire [1:0] ls_word_3;
	wire[1:0] ForwardA_3,ForwardB_3;
	wire[3:0] ALUctr_3;
	wire[15:0] imm16_3;
	wire[4:0] Rs_3,Rt_3,Rd_3,Rw_3;
	wire[31:0] busA_3,busB_3,result_3,busAnew_3,busBnew_3,lo_result_3;
	wire [13:0] o_EX_2; // i_EX = {Exop, alusrc, aluctr, regdst} =1+1+3+1 = 6
	wire [16:0] o_WB_2,i_WB_3;  // WB = Memtoreg,RegWr;//2
	wire [4:0] o_M_2,i_M_3; // M =Memwr
	wire [31:0] Exe_pc;
    //mem
    wire[31:0] result_4,busB_4,memory_4,mem_pc,lo_result_4;
	wire[4:0] Rw_4;
	wire overflow_4,hi_write_4,lo_write_4,mfhi_4,mflo_4,mtc0_4w,mfc0_4,syscall_4,Break_4,eret_4,cp0r_addr_4,RegWr_4,MemtoReg_4;
	wire inst_load_4,inst_store_4,lb_sign_4;
	wire [1:0] ls_word_4 ;
	wire[16:0] i_WB_4,o_WB_3;
	wire [4:0] o_M_3;

	//wr
	wire mfhi_5,mflo_5,mtc0_5w,mfc0_5,syscall_5,Break_5,eret_5,cp0r_addr_5,RegWr_5,MemtoReg_5,overflow_5,lo_write_5,hi_write_5;
	wire[4:0] Rw_5,o_Rw_5;
	wire [32:0] exc_bus;
	wire if_cancel;
	wire[31:0] busW_5,result_5,memory_5,wr_pc,lo_result_5;
	wire[16:0] o_WB_4,i_WB_5;
	
	//IF 
	PC pc(.clk(clk),.Reset(rst),.addr_in(addr_in),.addr_out(addr_out));
	IUnit iunit(.addr_in(addr_out),.instruction(instruction),.pc_plus_4(pc_plus_4));
	Mux_2_To_1_Width #32 mux_pc(.i_Select(data_hazard),.i_Data1 (pc_plus_4),.i_Data2 (n_addr_out),.o_Data(jbl_addr_in));
	assign {exc_vaild,exc_pc} = exc_bus;
	//assign addr_in = exc_vaild ? exc_pc : jbl_addr_in;
	Mux_2_To_1_Width #32 mux_exc(.i_Select(exc_vaild),.i_Data1(jbl_addr_in),.i_Data2(exc_pc),.o_Data  (addr_in));
	IF_ID_reg IF_ID(.clk(clk),.rst(rst | if_cancel),.if_stall(if_stall),.i_pc_plus_4(pc_plus_4),.i_Instruction(instruction),.o_pc_plus_4(address_2),.o_Instruction(o_instruction));
	assign ID_pc = address_2 ;
	//Reg_Dec(ID)译码阶段
	assign {mult_2,multu_2,div_2,divu_2,mthi_2,mtlo_2,mtc0_2e,Extop_2,ALUSrc_2,ALUctr_2,RegDst_2} = i_EX_2;//14
	assign {mfhi_2,mflo_2,mtc0_2w,mfc0_2,syscall_2,Break_2,eret_2,cp0r_addr_2,RegWr_2,MemtoReg_2} = i_WB_2;//17
	assign {inst_load_2,inst_store_2,lb_sign_2,ls_word_2} = i_M_2;//5位
	Decode decode(.Instruction(o_instruction),.Op(Op),.Rs(Rs_2),.Rt(Rt_2),.Rd(Rd_2),.shamt(shamt),.func(func),.imm16(imm16_2),.Target(target_2),.cp0r_sel(cp0r_sel_2));
	//Forwarding
	Mux_4_To_1 #32 mux_1(.i_Select(ForwardA_2),.i_Data1 (newbusA_2),.i_Data2 (result_4),.i_Data3 (busW_5),.i_Data4 (0),.o_Data  (busAnew_2));
	Mux_4_To_1 #32 mux_2(.i_Select(ForwardB_2),.i_Data1 (busB_2),.i_Data2 (result_4),.i_Data3 (busW_5),.i_Data4 (0),.o_Data  (busBnew_2));
	FrowardingUnit forwarding(.Ex_Mem_RegWr(RegWr_4),.Mem_Wr_RegWr(RegWr_5),.ID_Ex_Rt(Rt_2),.ID_Ex_Rs(Rs_2),.Ex_Mem_Rd(Rw_4),.Mem_Wr_Rd(Rw_5),.ALUsrcA(ForwardA_2),.ALUsrcB(ForwardB_2));
	//Normal
	Id_ctrl ctrl(.Branch(Branch_2),.Jump(Jump_2),.n_busA(newbusA_2),.Op(Op),.func(func),.Rs(Rs_2),.Rt(Rt_2),.Rd(Rd_2),.shamt(shamt),.busA(busA_2),.busB(busB_2),.cp0r_sel(cp0r_sel_2),.exe_ctrl(i_EX_2),.mem_ctrl(i_M_2),.wb_ctrl(i_WB_2));
	//assign Rw = RegDst ? Rd : Rb;//选择写入寄存器的多选器
	Regfile regfile(.clk(clk),.RegWr(RegWr_5),.Overflow(overflow_5),.Ra(Rs_2),.Rb(Rt_2),.Rw(o_Rw_5),.Busw(busW_5),.BusA(busA_2),.BusB(busB_2));
	//Hazard Detection(对于branch指令的阻塞后对指令的转发)
	pipctrlHD_Unit pip(.Jump(Jump_2),.Branch(Branch_2),.addr_in(address_2),.imm16(imm16_2),.target(target_2),.BusA(busAnew_2),.BusB(busBnew_2),.Rd(Rd_2),.addr_out(n_addr_out),.if_stall(if_stall),.data_hazard(data_hazard),.ID_EX_MemtoReg(MemtoReg_3),.ID_Ex_Rt(Rw_3),.IF_ID_Rs(Rs_2),.IF_ID_Rt(Rt_2),.load_use(loaduseHD_2),.ID_EX_RegWr(RegWr_3),.Ex_Mem_MemtoReg(MemtoReg_4),.Ex_Mem_Rt(Rw_4),.branchHD(branchHD_2),.newbusA(JbrnewbusA),.newbusB(JbrnewbusB),.newRd(jbrnewRd));
	ID_EX_reg ID_Ex(.clk(clk),.rst(if_stall | rst | if_cancel),.i_WB(i_WB_2),.i_M(i_M_2),.i_EX(i_EX_2),.i_Rs(Rs_2),.i_Rt(Rt_2),.i_imm16(imm16_2),.i_BusA(JbrnewbusA),.i_BusB(JbrnewbusB),.i_Rd(jbrnewRd),.i_pc(address_2),.o_WB(o_WB_2),.o_M(o_M_2),.o_EX(o_EX_2) ,.o_Rs(Rs_3),.o_Rt(Rt_3),.o_imm16(imm16_3),.o_BusA(busA_3),.o_BusB(busB_3),.o_Rd(Rd_3),.o_pc(Exe_pc),.load_used(loaduseHD_2));

	//Exec(Ex)执行阶段
	assign {mult_3,multu_3,div_3,divu_3,mthi_3,mtlo_3,mtc0_3e,Extop_3,ALUSrc_3,ALUctr_3,RegDst_3} = o_EX_2;
	assign {mfhi_3,mflo_3,mtc0_3w,mfc0_3,syscall_3,Break_3,eret_3,cp0r_addr_3,RegWr_3,MemtoReg_3} = o_WB_2;
	assign {inst_load_3,inst_store_3,lb_sign_3,ls_word_3 } = o_M_2;
	assign i_WB_3 = o_WB_2;
	assign i_M_3 = o_M_2;
	Mux_4_To_1 #32 mux_3(.i_Select(ForwardA_3),.i_Data1 (busA_3),.i_Data2 (result_4),.i_Data3 (busW_5),.i_Data4 (0),.o_Data  (busAnew_3));
	Mux_4_To_1 #32 mux_4(.i_Select(ForwardB_3),.i_Data1 (busB_3),.i_Data2 (result_4),.i_Data3 (busW_5),.i_Data4 (0),.o_Data  (busBnew_3));
	FrowardingUnit Forwarding(.Ex_Mem_RegWr(RegWr_4),.Mem_Wr_RegWr(RegWr_5),.ID_Ex_Rt(Rt_3),.ID_Ex_Rs(Rs_3),.Ex_Mem_Rd(Rw_4),.Mem_Wr_Rd(Rw_5),.ALUsrcA(ForwardA_3),.ALUsrcB(ForwardB_3));
	ExecUnit exe(.mult(mult_3),.multu(multu_3),.div(div_3),.divu(divu_3),.mthi(mthi_3),.mtlo(mtlo_3),.mtc0(mtc0_3e),.ExtOp(Extop_3),.Alusrc(ALUSrc_3),.Aluctr(ALUctr_3),.BusA(busAnew_3),.BusB(busBnew_3),.imm16(imm16_3),.overflow(overflow_3),.hi_write(hi_write_3),.lo_write(lo_write_3),.exe_result(result_3),.lo_result(lo_result_3));
	Ex_Mem_reg Ex_Mem(.clk(clk),.rst(rst | if_cancel),.i_WB(i_WB_3),.i_M(i_M_3),.i_overflow(overflow_3),.i_hi_write(hi_write_3),.i_lo_write(lo_write_3),.i_result(result_3),.i_BusB(busBnew_3),.i_Rw(Rw_3),.i_lo_result(lo_result_3),.o_WB(o_WB_3),.i_pc(Exe_pc),.o_M(o_M_3),.o_overflow(overflow_4),.o_lo_write(lo_write_4),.o_hi_write(hi_write_4),.o_result(result_4),.o_BusB(busB_4),.o_Rw(Rw_4),.o_lo_result(lo_result_4),.o_pc(mem_pc));
	Mux_2_To_1_Width #5 mux2_3(.i_Select(RegDst_3),.i_Data1 (Rt_3),.i_Data2 (Rd_3),.o_Data (Rw_3));

	//Mem访存阶段
	assign {mfhi_4,mflo_4,mtc0_4w,mfc0_4,syscall_4,Break_4,eret_4,cp0r_addr_4,RegWr_4,MemtoReg_4} = o_WB_3;
	assign {inst_load_4,inst_store_4,lb_sign_4,ls_word_4 } = o_M_3;
	assign i_WB_4 = o_WB_3;
	dm_4k dm(.addr(result_4[11:0]),.din(busB_4),.mem_ctrl(o_M_3),.clk(clk),.dout(memory_4));//数据存储器
	Mem_Wr_reg Mem_wr(.clk(clk | if_cancel),.rst(rst),.i_WB(i_WB_4),.i_overflow(overflow_4),.i_Dm(memory_4),.i_lo_write(lo_write_4),.i_hi_write(hi_write_4),.i_result(result_4),.i_lo_result(lo_result_4),.i_Rw(Rw_4),.i_pc(mem_pc),.o_WB(o_WB_4),.o_overflow(overflow_5),.o_Dm(memory_5),.o_lo_write(lo_write_5),.o_hi_write(hi_write_5),.o_result(result_5),.o_lo_result(lo_result_5),.o_Rw(Rw_5),.o_pc(wr_pc));
	
	//写回寄存器阶段
	assign {mfhi_5,mflo_5,mtc0_5w,mfc0_5,syscall_5,Break_5,eret_5,cp0r_addr_5,RegWr_5,MemtoReg_5} = o_WB_4;
	assign i_WB_5 = o_WB_4;
	Wr wb(.clk(clk),.wb_ctrl(o_WB_4),.hi_write(hi_write_5),.lo_write(lo_write_5),.lo_result(lo_result_5),.rf_addr(Rw_5),.mem_result(memory_5),.pc(wr_pc),.alu_result(result_5),.RegWr(RegWr_5),.busw(busW_5),.exc_bus(exc_bus),.if_cancel(if_cancel),.Rw(o_Rw_5));
	//Mux_2_To_1_Width #32 Mux_result(.i_Select(MemtoReg_5),.i_Data1 (result_5),.i_Data2 (memory_5),.o_Data  (busW_5));	
endmodule // Datapath
