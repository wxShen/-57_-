//加法器的实现(有一个加法器，三个数据选择器，扩展器，或门阵列，异或门阵列，alu操作控制信号组成)
module ALU #(parameter WIDTH=32) (ALUctr,A,B,Result,Overflow);//对alu扩展至12 中运算
	input [3:0] ALUctr;
	input [WIDTH-1:0] A;
	input [WIDTH-1:0] B;
	output Overflow;
	output reg[WIDTH-1:0] Result;
	//控制信号的定义
 	wire SUBctr,OVctr,SIGctr;
 	wire [1:0] Opctr;
 	wire [2:0] Opctr1;//对逻辑运算的选择
 	//运算过程需要的变量
 	wire [WIDTH-1 : 0] ext_subctr, OR_result,Xor_result,less_result,add_result,alu_result1,alu_nor,alu_and,alu_xor,alu_sll,alu_srl,alu_sra,alu_lui;
 	wire Overflow1,less,add_carry,add_sign;

 	//对于基本的alu运算的alu控制信号的产生（对ALUctr信号进行的三位编码对应课本的11条指令的实现）
 	assign SUBctr =!ALUctr[3] & ALUctr[2]; 
 	assign OVctr = !ALUctr[3] & !ALUctr[1] & ALUctr[0];
 	assign SIGctr =!ALUctr[3] & ALUctr[0];
 	assign Opctr[1] =(!ALUctr[3] & (ALUctr[2] & ALUctr[1])) | (!ALUctr[3] & !ALUctr[2] & ALUctr[1] & ALUctr[0]);
 	assign Opctr[0] = !ALUctr[3] & !ALUctr[2] & ((ALUctr[1] & !ALUctr[0])  | (!ALUctr[2] & ALUctr[0]));
 	assign Opctr1[2] = ALUctr[3] & ALUctr[2];
 	assign Opctr1[1] = ALUctr[3] & ALUctr[1];
 	assign Opctr1[0] = ALUctr[3] & ALUctr[0];
 	//逻辑运算结果
 	assign OR_result = A | B;
 	assign alu_nor = ~OR_result;
 	assign alu_and = A & B;          // 与结果为两数按位与
    assign alu_xor = A ^ B;      // 异或结果为两数按位异或
    assign alu_lui = {B[15:0], 16'd0};  // 立即数装载结果为立即数移位至高半字节(可先对立即数零扩展到32位)
    //-----{移位器}begin
    // 移位分三步进行，
    // 第一步根据移位量低2位即[1:0]位做第一次移位，
    // 第二步在第一次移位基础上根据移位量[3:2]位做第二次移位，
    // 第三步在第二次移位基础上根据移位量[4]位做第三次移位。
    wire [4:0] shf;
    assign shf = A[4:0];
    wire [1:0] shf_1_0;
    wire [1:0] shf_3_2;
    assign shf_1_0 = shf[1:0];
    assign shf_3_2 = shf[3:2];
    
     // 逻辑左移
    wire [31:0] sll_step1;
    wire [31:0] sll_step2;
    assign sll_step1 = {32{shf_1_0 == 2'b00}} & B                   // 若shf[1:0]="00",不移位
                     | {32{shf_1_0 == 2'b01}} & {B [30:0], 1'd0}     // 若shf[1:0]="01",左移1位
                     | {32{shf_1_0 == 2'b10}} & {B[29:0], 2'd0}     // 若shf[1:0]="10",左移2位
                     | {32{shf_1_0 == 2'b11}} & {B[28:0], 3'd0};    // 若shf[1:0]="11",左移3位
    assign sll_step2 = {32{shf_3_2 == 2'b00}} & sll_step1                  // 若shf[3:2]="00",不移位
                     | {32{shf_3_2 == 2'b01}} & {sll_step1[27:0], 4'd0}    // 若shf[3:2]="01",第一次移位结果左移4位
                     | {32{shf_3_2 == 2'b10}} & {sll_step1[23:0], 8'd0}    // 若shf[3:2]="10",第一次移位结果左移8位
                     | {32{shf_3_2 == 2'b11}} & {sll_step1[19:0], 12'd0};  // 若shf[3:2]="11",第一次移位结果左移12位
    assign alu_sll = shf[4] ? {sll_step2[15:0], 16'd0} : sll_step2;     // 若shf[4]="1",第二次移位结果左移16位

    // 逻辑右移
    wire [31:0] srl_step1;
    wire [31:0] srl_step2;
    assign srl_step1 = {32{shf_1_0 == 2'b00}} & B                   // 若shf[1:0]="00",不移位
                     | {32{shf_1_0 == 2'b01}} & {1'd0, B[31:1]}     // 若shf[1:0]="01",右移1位,高位补0
                     | {32{shf_1_0 == 2'b10}} & {2'd0, B[31:2]}     // 若shf[1:0]="10",右移2位,高位补0
                     | {32{shf_1_0 == 2'b11}} & {3'd0, B[31:3]};    // 若shf[1:0]="11",右移3位,高位补0
    assign srl_step2 = {32{shf_3_2 == 2'b00}} & srl_step1                  // 若shf[3:2]="00",不移位
                     | {32{shf_3_2 == 2'b01}} & {4'd0, srl_step1[31:4]}    // 若shf[3:2]="01",第一次移位结果右移4位,高位补0
                     | {32{shf_3_2 == 2'b10}} & {8'd0, srl_step1[31:8]}    // 若shf[3:2]="10",第一次移位结果右移8位,高位补0
                     | {32{shf_3_2 == 2'b11}} & {12'd0, srl_step1[31:12]}; // 若shf[3:2]="11",第一次移位结果右移12位,高位补0
    assign alu_srl = shf[4] ? {16'd0, srl_step2[31:16]} : srl_step2;    // 若shf[4]="1",第二次移位结果右移16位,高位补0
 
    // 算术右移
    wire [31:0] sra_step1;
    wire [31:0] sra_step2;
    assign sra_step1 = {32{shf_1_0 == 2'b00}} & B                                // 若shf[1:0]="00",不移位
                     | {32{shf_1_0 == 2'b01}} & { B [31], B[31:1]}           // 若shf[1:0]="01",右移1位,高位补符号位
                     | {32{shf_1_0 == 2'b10}} & {{2{B[31]}}, B[31:2]}      // 若shf[1:0]="10",右移2位,高位补符号位
                     | {32{shf_1_0 == 2'b11}} & {{3{B[31]}}, B[31:3]};     // 若shf[1:0]="11",右移3位,高位补符号位
    assign sra_step2 = {32{shf_3_2 == 2'b00}} & sra_step1                                // 若shf[3:2]="00",不移位
                     | {32{shf_3_2 == 2'b01}} & {{4{sra_step1[31]}}, sra_step1[31:4]}    // 若shf[3:2]="01",第一次移位结果右移4位,高位补符号位
                     | {32{shf_3_2 == 2'b10}} & {{8{sra_step1[31]}}, sra_step1[31:8]}    // 若shf[3:2]="10",第一次移位结果右移8位,高位补符号位
                     | {32{shf_3_2 == 2'b11}} & {{12{sra_step1[31]}}, sra_step1[31:12]}; // 若shf[3:2]="11",第一次移位结果右移12位,高位补符号位
    assign alu_sra = shf[4] ? {{16{sra_step2[31]}}, sra_step2[31:16]} : sra_step2;    // 若shf[4]="1",第二次移位结果右移16位,高位补符号位
 	
    Sign_Ext #1 sign_ext(.in(SUBctr),.out(ext_subctr));
 	assign Xor_result = B ^ ext_subctr;
 	Adder #32 Adder(.A(A),.B(Xor_result),.Cin(SUBctr),
 					.Result(add_result),.Cout(add_carry),.Overflow(Overflow1),.Sign(add_sign));
 	Mux_2_To_1 mux_less(.i_Select(SIGctr),.i_Data1 (SUBctr ^ add_carry),
 							.i_Data2 (Overflow ^ add_sign),.o_Data  (less));
	Mux_2_To_1_Width #32 mux_re(.i_Select(less),.i_Data1(32'h0000_0000),.i_Data2(32'h0000_0001),.o_Data(less_result));
	Mux_4_To_1 #32 mux_result1(.i_Select(Opctr),.i_Data1(add_result),.i_Data2 (OR_result),
							.i_Data3 (less_result),.i_Data4 (alu_nor),.o_Data  (alu_result1));
    assign Overflow = !ALUctr[3] & Overflow1;
    always @(*)
        begin
    	case(Opctr1)
    		3'b000 : Result <= alu_result1;
    		3'b001 : Result <= alu_and;
    		3'b010 : Result <= alu_xor;
    		3'b011 : Result <= alu_sll;
    		3'b100 : Result <= alu_srl;
    		3'b101 : Result <= alu_sra;
    		3'b110 : Result <= alu_lui;
            default : Result <=32'b0;//定义了一个空操作
    	endcase 
        end
endmodule

