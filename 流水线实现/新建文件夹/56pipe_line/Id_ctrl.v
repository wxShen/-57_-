module Id_ctrl (Branch,Jump,n_busA,Op,func,Rs,Rt,Rd,shamt,busA,busB,cp0r_sel,exe_ctrl,mem_ctrl,wb_ctrl);
	input [5:0] Op,func;
	input [4:0] Rt,Rs,Rd,shamt;
	input [2:0] cp0r_sel;
	input [31:0] busA,busB;
	
	output reg[7:0] Branch;
	output reg[3:0] Jump;
	output [31:0] n_busA;
	output reg[13:0] exe_ctrl; //exe_ctrl : mult,multu,div,divu,mthi,mtlo,ALUctr//10+4
    output reg[4:0] mem_ctrl;	//在访存阶段需要对load指令进行区分//MEM需要使用的控制信号//5位
    output reg[16:0] wb_ctrl; //wb_ctrl: mfhi,mflo,mtc0,mfc0,syscall,break,eret,RegWr //9+7
	
	wire RegDst,ALUsrc,MemtoReg,RegWr,MemWr,ExtOp,R_type;
	reg[3:0] ALUctr;
	wire sa_zero;
	wire add,addu,sub,subu,slt,sltu,div,divu,mult,multu,And,Nor,Or,Xor,sllv,sll,srav,sra,srlv,srl,//所有实现的指令集
	 	 ori,addiu,slti,sltiu,xori,andi,lui,
		 lw,lb,lbu,lh,lhu,sw,sb,sh,
		 beq,bne,bgez,bgtz,blez,bltz,bgezal,bltzal,j,jal,jr,jalr,
		 mfhi,mflo,mthi,mtlo,
		 Break,syscall,eret,mfc0,mtc0;
	//算术运算指令
	assign sa_zero = ~(|shamt);
	assign R_type =   !Op[5] & !Op[4] & !Op[3] & !Op[2] & !Op[1] & !Op[0];//000000
	//（add,addu,sub,subu,slt,sltu,div,divu,mult,multu,and,nor,or,xor,sllv,sll,srav,sra,srlv,srl）
	assign add    =    R_type &  func[5] & !func[4] & !func[3] & !func[2] & !func[1] & !func[0] & sa_zero  ;//100000
	assign addu   =    R_type &  func[5] & !func[4] & !func[3] & !func[2] & !func[1] &  func[0] & sa_zero  ;//100001
	assign sub    =    R_type &  func[5] & !func[4] & !func[3] & !func[2] &  func[1] & !func[0] & sa_zero  ;//100010
	assign subu   =    R_type &  func[5] & !func[4] & !func[3] & !func[2] &  func[1] &  func[0] & sa_zero  ;//100011
	assign slt    =    R_type &  func[5] & !func[4] &  func[3] & !func[2] &  func[1] & !func[0] & sa_zero  ;//101010
	assign sltu   =    R_type &  func[5] & !func[4] &  func[3] & !func[2] &  func[1] &  func[0] & sa_zero  ;//101011
	assign div    =    R_type & !func[5] &  func[4] &  func[3] & !func[2] &  func[1] & !func[0] & sa_zero & (Rd == 5'b00000) ;//011010
	assign divu   =    R_type & !func[5] &  func[4] &  func[3] & !func[2] &  func[1] &  func[0] & sa_zero & (Rd == 5'b00000) ;//011011
	assign mult   =    R_type & !func[5] &  func[4] &  func[3] & !func[2] & !func[1] & !func[0] & sa_zero & (Rd == 5'b00000) ;//011000
	assign multu  =    R_type & !func[5] &  func[4] &  func[3] & !func[2] & !func[1] &  func[0] & sa_zero & (Rd == 5'b00000) ;//011001
	assign And    =    R_type &  func[5] & !func[4] & !func[3] &  func[2] & !func[1] & !func[0] & sa_zero ;//100100
	assign Nor    =    R_type &  func[5] & !func[4] & !func[3] &  func[2] &  func[1] &  func[0] & sa_zero ;//100111
	assign Or     =    R_type &  func[5] & !func[4] & !func[3] &  func[2] & !func[1] &  func[0] & sa_zero  ;//100101
	assign Xor    =    R_type &  func[5] & !func[4] & !func[3] &  func[2] &  func[1] & !func[0] & sa_zero ;//100110
	assign sll    =    R_type & !func[5] & !func[4] & !func[3] & !func[2] & !func[1] & !func[0] & (Rs == 5'b00000) & !sa_zero;//000000
	assign sllv   =    R_type & !func[5] & !func[4] & !func[3] &  func[2] & !func[1] & !func[0] & sa_zero  ;//000100
	assign sra    =    R_type & !func[5] & !func[4] & !func[3] & !func[2] &  func[1] &  func[0] & (Rs == 5'b00000) & !sa_zero;//000011
	assign srav   =    R_type & !func[5] & !func[4] & !func[3] &  func[2] &  func[1] &  func[0] & sa_zero  ;//000111
	assign srlv   =    R_type & !func[5] & !func[4] & !func[3] &  func[2] &  func[1] & !func[0] & sa_zero  ;//001100
	assign srl    =    R_type & !func[5] & !func[4] & !func[3] & !func[2] &  func[1] & !func[0] & (Rs == 5'b00000) & !sa_zero;//000010

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
	assign beq    =   !Op[5] & !Op[4] & !Op[3] &  Op[2] & !Op[1] & !Op[0] && !(busA ^ busB);//000100
	assign bne    =   !Op[5] & !Op[4] & !Op[3] &  Op[2] & !Op[1] &  Op[0] &&  (busA ^ busB);//000101
	assign bgez   =   !Op[5] & !Op[4] & !Op[3] & !Op[2] & !Op[1] &  Op[0] & (Rt == 5'b00001) & (!busA[31]);//000001 //注其中rt=00001 //busA >= 0
	assign bgtz   =   !Op[5] & !Op[4] & !Op[3] &  Op[2] &  Op[1] &  Op[0] & (Rt == 5'b00000) & (!busA[31] &  (|busA));//000111 //busA > 0
	assign blez   =   !Op[5] & !Op[4] & !Op[3] &  Op[2] &  Op[1] & !Op[0] & (Rt == 5'b00000) & ( busA[31] | ~(|busA));//000110 //busA <= 0
	assign bltz   =   !Op[5] & !Op[4] & !Op[3] & !Op[2] & !Op[1] &  Op[0] & (Rt == 5'b00000) & ( busA[31]);//000001 //注其中rt=00000 //busA < 0
	assign bgezal =   !Op[5] & !Op[4] & !Op[3] & !Op[2] & !Op[1] &  Op[0] & (Rt == 5'b10001) &  (!busA[31]);//000001 //注其中rt=10001 //busA >=0
	assign bltzal =   !Op[5] & !Op[4] & !Op[3] & !Op[2] & !Op[1] &  Op[0] & (Rt == 5'b10000) &  ( busA[31]);//000110 //注其中rt=10000//busA < 0
	//j指令集
	assign j      =   !Op[5] & !Op[4] & !Op[3] & !Op[2] &  Op[1] & !Op[0];//000010
	//在此条Nop指令执行时写rd（$ra）寄存器的操作）Rf[31] = B_pc + 4;
	assign jal    =   !Op[5] & !Op[4] & !Op[3] & !Op[2] &  Op[1] &  Op[0];//000011
	//对于jr指令将rs寄存器需要将rs写到pc中;
	assign jr     =    R_type & (Rt == 5'b00000) & (Rd == 5'b00000) & sa_zero  & (func == 6'b001000);//R型指令 //注func = 001000,{rt,rd} = 10'b0; shf = 00000;
		//下两个以跳转指令需要写寄存器（由于执行j指令时需要将流水线前两个段寄存器清空，可选择在此条Nop指令执行时写rd（$ra）寄存器的操作）
	assign jalr   =    R_type & (Rt == 5'b00000) &  (Rd == 5'b11111) & sa_zero & (func == 6'b001001);//R型指令(一般默认rd=31) //注func = 001001 , rt = 00000, shf = 00000;
//数据移动
	assign mfhi   =    R_type & (Rs == 5'b00000) & (Rt == 5'b00000) & sa_zero & (func == 6'b010000);//R型指令 除func=010000,rd寄存器其余的均为0
	assign mflo   =    R_type & (Rs == 5'b00000) & (Rt == 5'b00000) & sa_zero & (func == 6'b010010);//R型指令 除func= 010010，rd其余的均为0
	assign mthi   =    R_type & (Rt == 5'b00000) & (Rd == 5'b00000) & sa_zero & (func == 6'b010001);//R型指令 除func= 010001，rs其余的均为0
	assign mtlo   =    R_type & (Rt == 5'b00000) & (Rd == 5'b00000) & sa_zero & (func == 6'b010011);//R型指令 除func= 010011，rs其余的均为0
//自陷指令
	assign Break  =   !Op[5] & !Op[4] &  Op[3] &  Op[2] & !Op[1] &  Op[0] & (func == 6'b001101);//func = 001101;
	assign syscall =  !Op[5] & !Op[4] &  Op[3] &  Op[2] & !Op[1] & !Op[0] & (func == 6'b001100);//func = 001100;
//特权指令	
	assign eret  =   !Op[5] &  Op[4] & !Op[3] & !Op[2] & !Op[1] & !Op[0] & (Rs == 5'b10000) & (Rt == 5'b00000) & (Rd == 5'b00000) & sa_zero & (func == 6'b011000);//010000
	assign mfc0  =   !Op[5] &  Op[4] & !Op[3] & !Op[2] & !Op[1] & !Op[0] & (Rs == 5'b00000) & !func[5] & !func[4] & !func[3] & sa_zero;//010000,rs=00000
	assign mtc0  =   !Op[5] &  Op[4] & !Op[3] & !Op[2] & !Op[1] & !Op[0] & (Rs == 5'b00100) & !func[5] & !func[4] & !func[3] & sa_zero;//010000,rs=00100

//跳转分支指令
    wire inst_jr;    //寄存器跳转指令
    wire inst_j_link;//链接跳转指令
    wire inst_B_link;
    assign inst_jr     = jalr | jr;
    assign inst_j_link = jal  | jalr;
    assign inst_B_link =bgezal|bgezal;

    //load store
    wire inst_load;
    wire inst_store;
    assign inst_load  =lw | lb | lbu | lh | lhu; // load指令
    assign inst_store = sw | sb | sh;           // store指令

	//对指令进行分类便于控制以及ALU的操作
    //alu操作分类
    wire inst_add, inst_sub, inst_slt,inst_sltu,inst_subu,inst_addu;
    wire inst_and, inst_nor, inst_or, inst_xor;
    wire inst_sll, inst_srl, inst_sra,inst_lui;
    wire [13:0] alu_type;
    assign inst_add = add  | addi ;               // 做加法(考虑溢出)
    assign inst_addu= addu |addiu | inst_load | inst_store | inst_j_link | inst_B_link;		          
    assign inst_sub = sub;                        // 减法（需考虑溢出）
    assign inst_subu = subu; 
    assign inst_slt = slt  | slti;                // 有符号小于置位
    assign inst_sltu= sltu | sltiu;               // 无符号小于置位
    assign inst_and = And  | andi;                // 逻辑与
    assign inst_nor = Nor;                        // 逻辑或非
    assign inst_or  = Or   | ori;                 // 逻辑或
    assign inst_xor = Xor  | xori;                // 逻辑异或
    assign inst_sll = sll  | sllv;                // 逻辑左移
    assign inst_srl = srl  | srlv;                // 逻辑右移
    assign inst_sra = sra  | srav;                // 算术右移
    assign inst_lui = lui;                        // 立即数装载高位
   
    
    //使用sa域作为偏移量的移位指令
    wire inst_shf_sa;
    assign inst_shf_sa =  sll | srl | sra;
    assign n_busA = (inst_shf_sa) ? {27'b0,shamt} : busA;

    //依据立即数扩展方式分类
    wire inst_imm_zero; //立即数0扩展
    wire inst_imm_sign; //立即数符号扩展
    assign inst_imm_zero = andi | lui  | ori  | xori;
    assign inst_imm_sign = addiu| slti | sltiu| addi
                         | inst_load | inst_store;
    
    //依据目的寄存器号分类
    wire inst_wdest_rt;  // 寄存器堆写入地址为rt的指令
    wire inst_wdest_31;  // 寄存器堆写入地址为31的指令
    wire inst_wdest_rd;  // 寄存器堆写入地址为rd的指令
    assign inst_wdest_rt = inst_imm_zero | addiu | addi | slti
                         | sltiu | inst_load | mfc0;
    assign inst_wdest_31 = jal;
    assign inst_wdest_rd = R_type  & !(mthi | mtlo) | inst_j_link | inst_B_link;

    //alu控制信号的生成aluctr
    assign alu_type = {inst_addu,inst_add,inst_or, inst_nor,inst_subu,inst_sub,inst_sltu,inst_slt,
   					   inst_and,inst_xor,inst_sll,inst_srl,inst_sra,inst_lui};
   	always @(*)
   	begin
   		case(alu_type)
   			14'b10_0000_0000_0000: ALUctr <= 4'b0000; //addu
   			14'b01_0000_0000_0000: ALUctr <= 4'b0001; //add
   			14'b00_1000_0000_0000: ALUctr <= 4'b0010; //or
   			14'b00_0100_0000_0000: ALUctr <= 4'b0011; //nor
   			14'b00_0010_0000_0000: ALUctr <= 4'b0100; //subu
   			14'b00_0001_0000_0000: ALUctr <= 4'b0101; //sub
   			14'b00_0000_1000_0000: ALUctr <= 4'b0110; //sltu
   			14'b00_0000_0100_0000: ALUctr <= 4'b0111; //slt
   			14'b00_0000_0010_0000: ALUctr <= 4'b1001; //and
   			14'b00_0000_0001_0000: ALUctr <= 4'b1010; //xor
   			14'b00_0000_0000_1000: ALUctr <= 4'b1011; //sll
   			14'b00_0000_0000_0100: ALUctr <= 4'b1100; //srl
   			14'b00_0000_0000_0010: ALUctr <= 4'b1101; //sra
   			14'b00_0000_0000_0001: ALUctr <= 4'b1110; //lui
   			default: ALUctr <= 4'b1111;
   		endcase // alutype
	end
	//assign Branch = beq | bne | bgez | bgtz | blez | bltz | bgezal | bltzal;
	always @(*)
		begin
			Branch <= {beq,bne,bgez,bgtz,blez,bltz,bgezal,bltzal};
			Jump <= {j,jal,jr,jalr};
		end
	//assign Jump = j | jal | jalr | jr;
	assign RegDst = inst_wdest_rd; 
	assign MemtoReg = inst_load;
	assign MemWr = inst_store;
	assign RegWr = R_type | ori | addiu | inst_load | slti | sltiu | xori | andi | lui |  inst_j_link | inst_B_link;
	assign ALUsrc = ori | addiu | inst_store | inst_load | slti | sltiu | xori | andi | lui; //与立即数相关的ALU源操作数的选择的控制信号
	assign ExtOp = inst_imm_sign;
    //对执行阶段，访存阶段，以及写回阶段用到的控制信号封装
   //访存需要用到的load/store信息
    wire lb_sign;  //load一字节为有符号load
    wire[1:0] ls_word;  //load/store为字节还是字,00:byte;01:two byte 10:word
    assign lb_sign = lw | lb | lh;//控制是否符号扩展
    assign ls_word = (lb | lbu) ? 2'b00 :((lh | lhu) ? 2'b01 : 2'b10); 

    wire [7 :0] cp0r_addr;
    assign cp0r_addr= {Rd,cp0r_sel};

   
    always @(*)
    	begin
    		exe_ctrl <={mult,multu,div,divu,mthi,mtlo,mtc0,ExtOp,ALUsrc,ALUctr,RegDst};
    		mem_ctrl <={inst_load,inst_store,lb_sign,ls_word};
    		wb_ctrl <={mfhi,mflo,mtc0,mfc0,syscall,Break,eret,cp0r_addr,RegWr,MemtoReg};
    	end
endmodule