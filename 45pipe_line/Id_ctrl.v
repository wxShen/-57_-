module Id_ctrl (Branch,Jump,RegDst,ALUsrc,ALUctr,MemtoReg,RegWr,MemWr,ExtOp,R_type,Op,func,Rs,Rt,Rd,busA,busB);
	input [5:0] Op,Fuc;
	input [4:0] Rt,Rs;
	output RegDst,ALUsrc,MemtoReg,RegWr,MemWr,ExtOp,R_type;
	output reg[3:0] ALUctr;
	output reg[7:0] Branch;
	output reg[3:0] Jump;

	wire [2:0] ALUtype,R_Aluctr;
	wire add,addu,sub,subu,slt,sltu,div,divu,mult,multu,And,Nor,Or,Xor,sllv,sll,srav,sra,srlv,srl
	 	 ori,addiu,slti,sltiu,xori,andi,lui,
		 lw,lb,lbu,lh,lhu,sw,sb,sh,
		 beq,bne,bgez,bgtz,blez,bltz,bgezal,bltzal,j,jal,jr,jalr,
		 mfhi,mflo,mthi,mtlo,
		 Break,syscall,eret,mfco,mtco;
	//算术运算指令
	assign R_type =   !Op[5] & !Op[4] & !Op[3] & !Op[2] & !Op[1] & !Op[0];//000000
	//（add,addu,sub,subu,slt,sltu,div,divu,mult,multu,and,nor,or,xor,sllv,sll,srav,sra,srlv,srl）
	assign add    =    R_type &  func[5] & !func[4] & !func[3] & !func[2] & !func[1] & !func[0] ;//100000
	assign addu   =    R_type &  func[5] &  func[4] & !func[3] & !func[2] & !func[1] &  func[0] ;//100001
	assign sub    =    R_type &  func[5] & !func[4] & !func[3] & !func[2] &  func[1] & !func[0] ;//100010
	assign subu   =    R_type &  func[5] & !func[4] & !func[3] & !func[2] &  func[1] &  func[0] ;//100011
	assign slt    =    R_type &  func[5] & !func[4] &  func[3] & !func[2] &  func[1] & !func[0] ;//101010
	assign sltu   =    R_type &  func[5] & !func[4] &  func[3] & !func[2] &  func[1] &  func[0] ;//101011
	assign div    =    R_type & !func[5] &  func[4] &  func[3] & !func[2] &  func[1] & !func[0] ;//011010
	assign divu   =    R_type & !func[5] &  func[4] &  func[3] & !func[2] &  func[1] &  func[0] ;//011011
	assign mult   =    R_type & !func[5] &  func[4] &  func[3] & !func[2] & !func[1] & !func[0] ;//011000
	assign multu  =    R_type & !func[5] &  func[4] &  func[3] & !func[2] & !func[1] &  func[0] ;//011001
	assign And    =    R_type &  func[5] & !func[4] & !func[3] &  func[2] & !func[1] & !func[0] ;//100100
	assign Nor    =    R_type &  func[5] & !func[4] & !func[3] &  func[2] &  func[1] &  func[0] ;//100111
	assign Or     =    R_type &  func[5] & !func[4] & !func[3] &  func[2] & !func[1] &  func[0] ;//100101
	assign Xor    =    R_type &  func[5] & !func[4] & !func[3] &  func[2] &  func[1] & !func[0] ;//100110
	assign sll    =    R_type & !func[5] & !func[4] & !func[3] & !func[2] & !func[1] & !func[0] ;//000000
	assign sllv   =    R_type & !func[5] & !func[4] & !func[3] &  func[2] & !func[1] & !func[0] ;//000100
	assign sra    =    R_type & !func[5] & !func[4] & !func[3] & !func[2] &  func[1] &  func[0] ;//000011
	assign srav   =    R_type & !func[5] & !func[4] & !func[3] &  func[2] &  func[1] &  func[0] ;//000111
	assign srlv   =    R_type & !func[5] & !func[4] & !func[3] &  func[2] &  func[1] & !func[0] ;//001100
	assign srl    =    R_type & !func[5] & !func[4] & !func[3] & !func[2] &  func[1] & !func[0] ;//000010

	assign ori    =   !Op[5] & !Op[4] &  Op[3] &  Op[2] & !Op[1] &  Op[0];//001101
	assign addi  =    !Op[5] & !Op[4] &  Op[3] & !Op[2] & !Op[1] & !Op[0];//001000
	assign addiu  =   !Op[5] & !Op[4] &  Op[3] & !Op[2] & !Op[1] &  Op[0];//001001
	assign slti   =   !Op[5] & !Op[4] &  Op[3] & !Op[2] &  Op[1] & !Op[0];//001010
	assign sltiu  =   !Op[5] & !Op[4] &  Op[3] & !Op[2] &  Op[1] &  Op[0];//001011
	assign xori   =   !Op[5] & !Op[4] &  Op[3] &  Op[2] &  Op[1] & !Op[0];//001110
	assign andi   =   !Op[5] & !Op[4] &  Op[3] & !Op[2] & !Op[1] & !Op[0];//001000
	assign lui    =   !Op[5] & !Op[4] &  Op[3] &  Op[2] &  Op[1] &  Op[0];//001111
	//访存指令
	assign lw     =    Op[5] & !Op[4] & !Op[3] & !Op[2] &  Op[1] &  Op[0];//100011
	assign lb  	  =    Op[5] & !Op[4] & !Op[3] & !Op[2] & !Op[1] & !Op[0];//100000
	assign lbu    =    Op[5] & !Op[4] & !Op[3] &  Op[2] & !Op[1] & !Op[0];//100100
	assign lh     =    Op[5] & !Op[4] & !Op[3] & !Op[2] & !Op[1] &  Op[0];//100001
	assign lhu    =    Op[5] & !Op[4] & !Op[3] &  Op[2] & !Op[1] &  Op[0];//100101
	
	assign sw     =    Op[5] & !Op[4] &  Op[3] & !Op[2] &  Op[1] &  Op[0];//101011
	assign sb     =    Op[5] & !Op[4] &  Op[3] & !Op[2] & !Op[1] & !Op[0];//101000
	assign sh     =    Op[5] & !Op[4] &  Op[3] & !Op[2] & !Op[1] &  Op[0];//101001
	//branch指令集(产生branch指令便于在第二个周期控制跳转)
	assign beq    =   !Op[5] & !Op[4] & !Op[3] &  Op[2] & !Op[1] & !Op[0] & !(busA ^ busB);//000100
	assign bne    =   !Op[5] & !Op[4] & !Op[3] &  Op[2] & !Op[1] &  Op[0] & (busA ^ busB);//000101
	assign bgez   =   !Op[5] & !Op[4] & !Op[3] & !Op[2] & !Op[1] &  Op[0] & (Rt == 5'b00001) & (!busA[31]);//000001 //注其中rt=00001 //busA >= 0
	assign bgtz   =   !Op[5] & !Op[4] & !Op[3] &  Op[2] &  Op[1] &  Op[0] & (Rt == 5'b00000) & (!busA[31] && (busA ^ 32'b0));//000111 //busA > 0
	assign blez   =   !Op[5] & !Op[4] & !Op[3] &  Op[2] &  Op[1] & !Op[0] & (Rt == 5'b00000) & ( busA[31] || !(busA ^ 32'b0));//000110 //busA <= 0
	assign bltz   =   !Op[5] & !Op[4] & !Op[3] & !Op[2] & !Op[1] &  Op[0] & (Rt == 5'b00000) & ( busA[31]);//000001 //注其中rt=00000 //busA < 0
	assign bgezal =   !Op[5] & !Op[4] & !Op[3] & !Op[2] & !Op[1] &  Op[0] & (Rt == 5'b10001) & (!busA[31]);//000001 //注其中rt=10001 //busA >=0
	assign bltzal =   !Op[5] & !Op[4] & !Op[3] & !Op[2] & !Op[1] &  Op[0] & (Rt == 5'b10000) & ( busA[31]);//000110 //注其中rt=10000//busA < 0
	//j指令集
	assign j      =   !Op[5] & !Op[4] & !Op[3] & !Op[2] &  Op[1] & !Op[0];//000010
	//在此条Nop指令执行时写rd（$ra）寄存器的操作）Rf[31] = B_pc + 4;
	assign jal    =   !Op[5] & !Op[4] & !Op[3] & !Op[2] &  Op[1] &  Op[0];//000011
	//对于jr指令将rs寄存器需要将rs写到pc中;
	assign jr     =   !Op[5] & !Op[4] & !Op[3] & !Op[2] & !Op[1] & !Op[0] & (func == 6'b001000);//R型指令 //注func = 001000,{rt,rd} = 10'b0; shf = 00000;
		//下两个以跳转指令需要写寄存器（由于执行j指令时需要将流水线前两个段寄存器清空，可选择在此条Nop指令执行时写rd（$ra）寄存器的操作）
	assign jalr   =   !Op[5] & !Op[4] & !Op[3] & !Op[2] & !Op[1] & !Op[0] & (func == 6'b001001);//R型指令 //注func = 001001 , rt = 00000, shf = 00000;
//数据移动
	assign mfhi   =   !Op[5] & !Op[4] & !Op[3] & !Op[2] & !Op[1] & !Op[0] & (func == 6'b010000);//R型指令 除func=010000,rd寄存器其余的均为0
	assign mflo   =   !Op[5] & !Op[4] & !Op[3] & !Op[2] & !Op[1] & !Op[0] & (func == 6'b010010);//R型指令 除func= 010010，rd其余的均为0
	assign mthi   =   !Op[5] & !Op[4] & !Op[3] & !Op[2] & !Op[1] & !Op[0] & (func == 6'b010001);//R型指令 除func= 010001，rs其余的均为0
	assign mtlo   =   !Op[5] & !Op[4] & !Op[3] & !Op[2] & !Op[1] & !Op[0] & (func == 6'b010011);//R型指令 除func= 010011，rs其余的均为0
//自陷指令
	assign Break  =   !Op[5] & !Op[4] &  Op[3] &  Op[2] & !Op[1] &  Op[0] & (func == 6'b011001);//func = 001101;
	assign syscall =  !Op[5] & !Op[4] &  Op[3] &  Op[2] & !Op[1] & !Op[0] & (func == 6'b001100);//func = 001100;
//特权指令	
	assign eret  =   !Op[5] &  Op[4] & !Op[3] & !Op[2] & !Op[1] & !Op[0];//010000
	assign mfco  =   !Op[5] &  Op[4] & !Op[3] & !Op[2] & !Op[1] & !Op[0] & (Rs == 5'b00000);//010000,rs=00000
	assign mtco  =   !Op[5] &  Op[4] & !Op[3] & !Op[2] & !Op[1] & !Op[0] & (Rs == 5'b00100);//010000,rs=00100

	//assign Branch = beq | bne | bgez | bgtz | blez | bltz | bgezal | bltzal;
	always @(*)
		begin
			Branch <= {beq,bne,bgez,bgtz,blez,bltz,bgezal,bltzal};
			Jump <= {j,jal,jr,jalr};
		end
	//assign Jump = j | jal | jalr | jr;
	assign RegDst = R_type;
	assign MemtoReg =lw | lb | lbu | lh | lhu;
	assign MemWr = sw | sb | sh;
	assign RegWr = R_type | ori | addiu | lw  | slti | sltiu | xori | andi | lui | lb | lbu | lh | lhu;
	assign ALUsrc = ori | addiu | sw | lw | slti | sltiu | xori | andi | lui | lb | lbu | lh | lhu | sb | sh; 
	assign ExtOp = addiu | lw | sw | sb | sh | lb | addi | slti |sltiu;

	//alu控制信号的生成

	case()
		
	/*
	assign ALUop[2] = beq;
	assign ALUop[1] =U ori;
	assign ALUop[0] = R_type;

	assign ctr3 = !Fuc[2] & Fuc[1];
	assign ctr2 = Fuc[3] & !Fuc[2] & Fuc[1];
	assign ctr1 =(!Fuc[3] & !Fuc[2] & !Fuc[1] & !Fuc[0]) | (!Fuc[2] & Fuc[1] & !Fuc[0]);
	assign R_Aluctr = {ctr3,ctr2,ctr1};


	Mux_2_To_1_Width #3 mux(.i_Select(R_type),.i_Data1 (ALUop),.i_Data2 (R_Aluctr),.o_Data  (ALUctr));
*/
endmodule