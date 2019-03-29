`include "mux.v"


module PipCtrl(Jump,Branch,address_in,imm16,target26,busA_in,busB_in,address_out,if_rst,if_stall,if_change1,loaduseHD,branchHD);//包含Branch的计算 最后输出一个下一个PC的结果、全部包好  要注意，如果要执行jump,branch，要reset一个周期
	input Jump,Branch,loaduseHD,branchHD;
	input[31:0] address_in,busA_in,busB_in;
	input[15:0] imm16;
	input[25:0] target26;
	output[31:0] address_out;
	output if_rst,if_stall,if_change1;
	//The computation of address_out form Jump or Branch
	wire[29:0] address_start,imm30,address_imm,target30,d_mux1,d_mux2;
	wire Branch_if,zero;
	wire address_decide;
	wire[31:0] result,address_out1,address_out2,address_out3;

	assign address_start = address_in[31:2];
	SignExt signExt_1(imm16,imm30);
	assign address_imm = address_start + imm30;
	assign target30 = {address_in[31:28],target26[25:0]};

	assign result = busA_in - busB_in;
	assign zero =  (result == 0) ? 1:0;

	assign Branch_if = Branch & zero;
	Mux2_30 mux2_1(address_start,address_imm,Branch_if,d_mux1);
	Mux2_30 mux2_2(d_mux1,target30,Jump,d_mux2);

	//generate the signal of if_rst and decide address_out 
	assign if_rst = (Branch_if & ~(Branch & branchHD)) | Jump;
	assign if_change1 = Branch_if | Jump | loaduseHD | (Branch & branchHD);
	//如果不为branch的时候  别随便阻塞  影响效率
	assign if_stall = (loaduseHD & ~(Branch_if | Jump)) | (Branch & branchHD);
	assign address_decide = Branch_if | Jump;

	assign address_out1 = address_in;
	assign address_out2 = d_mux2 * 4;
	Mux2_32 mux2_3(address_out1,address_out2,address_decide,address_out3);
	Mux2_32 mux2_4(address_out3,address_out1,(Branch & branchHD),address_out);
endmodule

module SignExt(imm,y);
	input[15:0] imm;
	output[29:0] y;
	assign y[15:0] = imm;
	assign y[29:16] = imm[15]? 14'b1:14'b0;
endmodule