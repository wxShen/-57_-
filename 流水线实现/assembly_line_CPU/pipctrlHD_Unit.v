module pipctrlHD_Unit (Jump,Branch,addr_in,imm16,target,BusA,BusB,addr_out,if_rst,if_stall,data_hazard,
	ID_EX_MemtoReg,ID_Ex_Rt,IF_ID_Rs,IF_ID_Rt,load_use,ID_EX_RegWr,Ex_Mem_MemtoReg,Ex_Mem_Rt,branchHD);//监测各种异常并解决以及计算Npc
	input Jump,Branch,ID_EX_MemtoReg,ID_EX_RegWr,Ex_Mem_MemtoReg;
	input [31:0] addr_in,BusA,BusB;
	input [25:0] target;
	input [15:0] imm16;
	input [4:0] IF_ID_Rt,IF_ID_Rs,ID_Ex_Rt,Ex_Mem_Rt;

	output if_rst,if_stall,data_hazard,load_use,branchHD;
	output [31:0] addr_out;
	wire zero;//用于对Npc的计算
	assign zero = ((BusA ^ BusB) == 0) ? 1 : 0;
	NPC npc(.imm16(imm16),.Branch(Branch & branchHD),.Zero(zero),.Jump(Jump),.pc(addr_in),.Target(target),.npc(addr_out));

	//load-use检测
	assign load_use = ID_EX_MemtoReg & ((IF_ID_Rt == ID_Ex_Rt) | (IF_ID_Rs == ID_Ex_Rt));//需要阻塞一次
	//branch 的数据阻塞检测
	assign branchHD =Branch & ((ID_EX_RegWr & ((IF_ID_Rs == ID_Ex_Rt) | (IF_ID_Rt == ID_Ex_Rt))) //对于阻塞两次次的情况
				| (Ex_Mem_MemtoReg & ((IF_ID_Rs == Ex_Mem_Rt) | (IF_ID_Rt == Ex_Mem_Rt)))); //stall一次的情况

	//generate the signal of if_rst and decide address_out 
	assign if_rst = ((Branch & zero) & ~(Branch & branchHD)) | Jump; //对IF_ID和ID_ex两个j寄存器清空(对于跳转指令和分支指令)
	assign data_hazard = (Branch & zero) | Jump | load_use| (Branch & branchHD);//对于在通过转发无法实现的数据冒险的检测需要进行阻塞
	//如果不为branch的时候  别随便阻塞  影响效率
	//assign if_stall = (load_use & ~((Branch & zero) | Jump)) | (Branch & branchHD);//对于branch的数据冒险对ID_Ex寄存器的控制信号的清空
	assign if_stall = load_use  | (Branch & branchHD);
 endmodule
