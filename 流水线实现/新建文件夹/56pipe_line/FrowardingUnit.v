 module FrowardingUnit (Ex_Mem_RegWr,Mem_Wr_RegWr,ID_Ex_Rt,ID_Ex_Rs,Ex_Mem_Rd,Mem_Wr_Rd,ALUsrcA,ALUsrcB);//可解决大多数数据冒险
input Ex_Mem_RegWr,Mem_Wr_RegWr;//暂时不知道alusrc控制指令在转发阶段起什么作用
input [4:0] ID_Ex_Rt,ID_Ex_Rs,Ex_Mem_Rd,Mem_Wr_Rd;

output reg [1:0] ALUsrcA,ALUsrcB;

//有四种检测条件（switch实现忘了如何操作，默默使用if_else语句）
always @( Ex_Mem_RegWr or Ex_Mem_Rd or ID_Ex_Rs or Mem_Wr_RegWr or Mem_Wr_Rd) begin
		if (Ex_Mem_RegWr & (Ex_Mem_Rd != 0) & (Ex_Mem_Rd == ID_Ex_Rs)) begin //C1(A) Ex阶段的情况
			ALUsrcA = 01;	
		end
		else if (Mem_Wr_RegWr & (Mem_Wr_Rd != 0) & ~(Ex_Mem_RegWr & (Ex_Mem_Rd != 0) & (Ex_Mem_Rd == ID_Ex_Rs)) & (Mem_Wr_Rd == ID_Ex_Rs)) begin//C2(A) 
			ALUsrcA = 10;
		end
		else begin
			ALUsrcA = 00;
		end
	end

	always @( Ex_Mem_RegWr or Ex_Mem_Rd or ID_Ex_Rt or Mem_Wr_RegWr or Mem_Wr_Rd) begin
		if (Ex_Mem_RegWr & (Ex_Mem_Rd != 0) & (Ex_Mem_Rd == ID_Ex_Rt)) begin  //(c1B)
			ALUsrcB = 01;
			
		end
		else if (Mem_Wr_RegWr & (Mem_Wr_Rd != 0) & ~(Ex_Mem_RegWr & (Ex_Mem_Rd != 0) & (Ex_Mem_Rd == ID_Ex_Rt)) & (Ex_Mem_Rd == ID_Ex_Rt)) begin //C2B
			ALUsrcB = 10;
			
		end
		else begin
			ALUsrcB = 00;
		end
	end
endmodule