module ExecUnit (mult,multu,div,divu,mthi,mtlo,mtc0,ExtOp,Alusrc,Aluctr,BusA,BusB,imm16,overflow,hi_write,lo_write,exe_result,lo_result);
	input mult,multu,div,divu,mthi,mtlo,mtc0,ExtOp,Alusrc;
	input [3:0] Aluctr;
	input [31:0] BusA,BusB;
	input [15:0] imm16;

	output reg overflow;
	output hi_write,lo_write;
	output [31:0] exe_result,lo_result;

	wire[31:0] ext_imm,busb_result,alu_result;
	wire[63:0] mult_result;
	reg [31:0] div_remainder,div_quotient;
	//wire [31:0] div_result;
	wire overflow1;
	ext #(16,32) extimm(.Op(ExtOp),.in(imm16),.out(ext_imm));
	Mux_2_To_1_Width #32 mux_busb(.i_Select(Alusrc),.i_Data1 (BusB),.i_Data2 (ext_imm),.o_Data  (busb_result));
	ALU #32 alu(.ALUctr(Aluctr),.A(BusA),.B(busb_result),.Result(alu_result),.Overflow(overflow1));
	//乘法除法器的实现(当前直接使用* / 实现)如时间来得及再实现
	//multiply(clk,mult_begin,mult_op1,mult_op2, product, mult_end);
	assign mult_result = BusA * BusB;
	//整数乘法溢出判断：无符号：若Puh(高n位)=0，则不溢出，带符号：若Psh(高n位)每位全0或全1，且都等于Ps的最高位，则不溢出
	initial
		begin 
			div_remainder = 0;
			div_quotient = 0;
		end
	always @(div | divu)
		begin
			if(|BusB)
				begin
					div_remainder <= (BusA % BusB);//余数求解
					div_quotient <= (BusA / BusB);//商
				end
			else
				begin
					div_remainder = 0;
					div_quotient = 0;
				end
		end
	always @(*)//对于除法不会产生溢出有异常情况
		begin
			if(mult | multu)
				begin
					overflow <= ((multu & ~(|mult_result[63:32])) | 
						(mult & (~(|mult_result[63:32] & (mult_result[31] == 0))) |  
						(& mult_result[63:32] & (mult_result[31] == 1)))) ? 0 : 1;
				end
			else if(div | divu)
				begin 
					overflow <= 0;
				end
			else
				begin
					overflow <= overflow1;
				end
			end
	//要写入HI的值放在exe_result里，包括MULT和MTHI指令,
    //要写入LO的值放在lo_result里，包括MULT和MTLO指令,
    assign exe_result = mthi     ? BusA :
                        mtc0     ? BusB : //向协处理器 0 的寄存器存值
                        (mult| multu) ? mult_result[63:32] : 
                        (div | divu) ? div_remainder : alu_result;
    assign lo_result  = mtlo ? BusA : (mult | multu) ? mult_result[31:0] : div_quotient;

    assign hi_write   = mult | multu | div | divu | mthi;
    assign lo_write   = mult | multu | div | divu | mtlo;
endmodule