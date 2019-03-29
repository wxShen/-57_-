`include "ctrl.v"
`include "Ex_Mem.v"
`include "ID_Ex.v"
`include "IF_ID.v"
`include "im_translate.v"
`include "IUnit.v"
`include "Mem_Wr.v"
`include "mux.v"
`include "PC.v"
`include "PipCtrl.v"
`include "RegFile.v"
`include "Exec.v"
`include "dm.v"
`include "ForwardingUnit.v"
`include "HaDectUnit.v"

module datapath(clk,rst);
	input clk,rst;
//IF
	wire[31:0] PC_in,PC_out,address_1,ins_1;
	wire if_rst_2;
//ID
	wire[31:0] address_2,ins_2,busA_2,busB_2,busAnew_2,busBnew_2,PipCtrl_out;
	wire Branch_2,Jump_2,RegDst_2,ALUSrc_2,MemtoReg_2,RegWr_2,MemWr_2,Extop_2,loaduseHD_2,branchHD_2,if_ctrl,if_stall,if_change1;
	wire[1:0] ForwardA_2,ForwardB_2;
	wire[2:0] ALUctr_2;
	wire[4:0] Rs_2,Rt_2,Rd_2;
	wire[15:0] imm16_2;
	wire[25:0] target26_2;
//Ex
	wire RegDst_3,ALUSrc_3,MemtoReg_3,RegWr_3,MemWr_3,Extop_3;
	wire[1:0] ForwardA_3,ForwardB_3;
	wire[2:0] ALUctr_3;
	wire[15:0] imm16_3;
	wire[4:0] Rs_3,Rt_3,Rd_3,Rw_3;
	wire[31:0] busA_3,busB_3,result_3,busAnew_3,busBnew_3;
//Mem
	wire[31:0] result_4,busB_4,memory_4;
	wire[4:0] Rw_4;
	wire MemtoReg_4,RegWr_4,MemWr_4;
//Wr
	wire RegWr_5,MemtoReg_5;
	wire[4:0] Rw_5;
	wire[31:0] busW_5,result_5,memory_5;
//IF
	PC PC_1(.clk(clk),.rst(rst),.address_in(PC_in),.address_out(PC_out));
	IUnit IUnit_1(.address_in(PC_out),.ins(ins_1),.address_out(address_1));
	Mux2_32 mux2_32_4(.d0(address_1),.d1(PipCtrl_out),.s(if_change1),.y(PC_in));
	IF_ID IF_ID_1(.clk(clk),.rst(if_rst_2),.if_stall(if_stall),.PC_in(address_1),.ins_in(ins_1),.PC_out(address_2),.ins_out(ins_2),.if_ctrl(if_ctrl));
//ID
	//Forwarding Unit
	Mux4_32 Mux4_32_3(.d0(busA_2),.d1(busW_5),.d2(result_4),.d3(0),.s(ForwardA_2),.y(busAnew_2));
	Mux4_32 Mux4_32_4(.d0(busB_2),.d1(busW_5),.d2(result_4),.d3(0),.s(ForwardB_2),.y(busBnew_2));
	ForwardingUnit ForwardingUnit2(.RegWr1(RegWr_4),.RegWr2(RegWr_5),.Rs(Rs_2),.Rt(Rt_2),.Rd1(Rw_4),.Rd2(Rw_5),.ForwardA(ForwardA_2),.ForwardB(ForwardB_2));
	//Hazard Detection
	PipCtrl PipCtrl_1(.Jump(Jump_2),.Branch(Branch_2),.address_in(address_2),.imm16(imm16_2),.target26(target26_2),
		.busA_in(busAnew_2),.busB_in(busBnew_2),.address_out(PipCtrl_out),.if_rst(if_rst_2),.if_stall(if_stall),.if_change1(if_change1),.loaduseHD(loaduseHD_2),.branchHD(branchHD_2));
	HaDectUnit HaDectUnit_1(.Rs(Rs_2),.Rt(Rt_2),.Rw1(Rw_3),.Rw2(Rw_4),.RegWr1(RegWr_3),.MemtoReg1(MemtoReg_3),.MemtoReg2(MemtoReg_4),.loaduseHD(loaduseHD_2),.branchHD(branchHD_2));
	//Normal
	ctrl ctrl_1(.dout(ins_2),.Branch(Branch_2),.Jump(Jump_2),.RegDst(RegDst_2),.ALUSrc(ALUSrc_2),.ALUctr(ALUctr_2),.MemtoReg(MemtoReg_2),.RegWr(RegWr_2),.MemWr(MemWr_2),.Extop(Extop_2));
	im_translate im_translate_1(.dout(ins_2),.Rs(Rs_2),.Rt(Rt_2),.Rd(Rd_2),.imm16(imm16_2),.target26(target26_2));
	RegFile RegFile_1(.clk(clk),.RegWr(RegWr_5),.Rw(Rw_5),.Ra(Rs_2),.Rb(Rt_2),.busW(busW_5),.busA(busA_2),.busB(busB_2));
	ID_Ex ID_Ex_1(.clk(clk),.rst(if_stall),.imm16_in(imm16_2),.busA_in(busA_2),.busB_in(busB_2),.Rs_in(Rs_2),.Rt_in(Rt_2),.Rd_in(Rd_2),.imm16_out(imm16_3),.busA_out(busA_3),.busB_out(busB_3),
		.Rs_out(Rs_3),.Rt_out(Rt_3),.Rd_out(Rd_3),.Extop_in(Extop_2),.ALUSrc_in(ALUSrc_2),.ALUctr_in(ALUctr_2),.MemtoReg_in(MemtoReg_2),.RegWr_in(RegWr_2),.MemWr_in(MemWr_2),.RegDst_in(RegDst_2),
		.Extop_out(Extop_3),.ALUSrc_out(ALUSrc_3),.ALUctr_out(ALUctr_3),.MemtoReg_out(MemtoReg_3),.RegWr_out(RegWr_3),.MemWr_out(MemWr_3),.RegDst_out(RegDst_3),.if_ctrl(if_ctrl));//signal 'rst' useless right now

//Ex
	//Forwarding Unit
	Mux4_32 Mux4_32_1(.d0(busA_3),.d1(busW_5),.d2(result_4),.d3(0),.s(ForwardA_3),.y(busAnew_3));
	Mux4_32 Mux4_32_2(.d0(busB_3),.d1(busW_5),.d2(result_4),.d3(0),.s(ForwardB_3),.y(busBnew_3));
	Mux2_5 mux2_5_1(.d0(Rt_3),.d1(Rd_3),.s(RegDst_3),.y(Rw_3));
	//Normal
	Exec Exec_1(.Extop(Extop_3),.ALUSrc(ALUSrc_3),.ALUctr(ALUctr_3),.busA(busAnew_3),.busB(busBnew_3),.imm16(imm16_3),.result(result_3));
	ForwardingUnit ForwardingUnit1(.RegWr1(RegWr_4),.RegWr2(RegWr_5),.Rs(Rs_3),.Rt(Rt_3),.Rd1(Rw_4),.Rd2(Rw_5),.ForwardA(ForwardA_3),.ForwardB(ForwardB_3));
	Ex_Mem Ex_Mem_1(.clk(clk),.rst(0),.result_in(result_3),.busB_in(busB_3),.Rw_in(Rw_3),.result_out(result_4),.busB_out(busB_4),.Rw_out(Rw_4),.MemtoReg_in(MemtoReg_3),.RegWr_in(RegWr_3),.MemWr_in(MemWr_3),.MemtoReg_out(MemtoReg_4),.RegWr_out(RegWr_4),.MemWr_out(MemWr_4));

//Mem
	dm dm_1(.addr(result_4[11:2]),.din(busB_4),.we(MemWr_4),.clk(clk),.dout(memory_4));
	Mem_Wr Mem_Wr_1(.clk(clk),.rst(0),.memory_in(memory_4),.result_in(result_4),.Rw_in(Rw_4),.memory_out(memory_5),.result_out(result_5),.Rw_out(Rw_5),.MemtoReg_in(MemtoReg_4),.RegWr_in(RegWr_4),.MemtoReg_out(MemtoReg_5),.RegWr_out(RegWr_5));

//Wr
	Mux2_32 mux2_32_3(.d0(result_5),.d1(memory_5),.s(MemtoReg_5),.y(busW_5));

endmodule









