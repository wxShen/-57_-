module Ctrl (Branch,Jump,RegDst,ALUsrc,ALUctr,MemtoReg,RegWr,MemWr,ExtOp,R_type,Op,Fuc);
	input [5:0] Op;
	output Branch,Jump,RegDst,ALUsrc,MemtoReg,RegWr,MemWr,ExtOp,R_type;
	output [2:0] ALUctr;

	wire [2:0] ALUop,R_Aluctr;
	wire ori,addiu,lw,sw,beq,jump,ctr1,ctr2,ctr3;//使用硬连接的方式
	assign R_type =  !Op[5] & !Op[4] & !Op[3] & !Op[2] & !Op[1] & !Op[0];
	assign ori   =   !Op[5] & !Op[4] &  Op[3] &  Op[2] & !Op[1] &  Op[0];
	assign addiu =   !Op[5] & !Op[4] &  Op[3] & !Op[2] & !Op[1] &  Op[0];
	assign lw    = 	  Op[5] & !Op[4] & !Op[3] & !Op[2] &  Op[1] &  Op[0];
	assign sw    =    Op[5] & !Op[4] &  Op[3] & !Op[2] &  Op[1] &  Op[0];
	assign beq   =   !Op[5] & !Op[4] & !Op[3] &  Op[2] & !Op[1] & !Op[0];
	assign jump  =   !Op[5] & !Op[4] & !Op[3] & !Op[2] &  Op[1] & !Op[0];

	assign Branch = beq;
	assign Jump = jump;
	assign RegDst = R_type;
	assign MemtoReg = lw;
	assign MemWr = sw;
	assign RegWr = R_type | ori | addiu | lw;
	assign ALUsrc = ori | addiu | sw | lw;
	assign ExtOp = addiu | lw |sw ;
	assign ALUop[2] = beq;
	assign ALUop[1] = ori;
	assign ALUop[0] = R_type;

	assign ctr3 = !Fuc[2] & Fuc[1];
	assign ctr2 = Fuc[3] & !Fuc[2] & Fuc[1];
	assign ctr1 =(!Fuc[3] & !Fuc[2] & !Fuc[1] & !Fuc[0]) | (!Fuc[2] & Fuc[1] & !Fuc[0]);
	assign R_Aluctr = {ctr3,ctr2,ctr1};

	Mux_2_To_1_Width #3 mux(.i_Select(R_type),.i_Data1 (ALUop),.i_Data2 (R_Aluctr),.o_Data  (ALUctr));

endmodule