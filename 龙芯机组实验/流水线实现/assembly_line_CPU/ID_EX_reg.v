module ID_EX_reg (clk,rst,i_WB,i_M,i_EX,i_Rs,i_Rt,i_imm16,i_BusA,i_BusB,i_Rd,i_func,
						  o_WB,o_M,o_EX,,o_Rs,o_Rt,o_imm16,o_BusA,o_BusB,o_Rd,o_func,load_used);
	input clk,rst,i_M; // M =Memwr
	input [5:0] i_EX; // i_EX = {Exop, alusrc, aluctr, regdst} =1+1+3+1 = 6
	input [1:0] i_WB;  // WB = Memtoreg,RegWr;//2
	input [4:0] i_Rs,i_Rt,i_Rd;
	input [31:0] i_BusA,i_BusB;
	input [15:0] i_imm16;
	input [5:0] i_func;
	input load_used;

	reg [144:0] ID_EX_reg; //6 + 3 + 15 + 64 + 16 + 6 = 110;

	output reg o_M;
	output reg [5:0] o_EX;
	output reg [1:0] o_WB;
	output reg [4:0] o_Rs,o_Rt,o_Rd;
	output reg [31:0] o_BusA,o_BusB;
	output reg [15:0] o_imm16;
	output reg [5:0] o_func;

	initial
		begin
			ID_EX_reg <= 142'b0;
		end
		
	always @(*)
		begin
	  		ID_EX_reg <= {i_WB,i_M,i_EX,i_Rs,i_Rt,i_imm16,i_BusA,i_BusB,i_Rd,i_func};
		end

	always @(negedge clk)
		begin
			if(load_used | rst )//对于load_used发生时应该将所有的控制信号清零(相当于插入了一个气泡)
			 	begin
					ID_EX_reg = 142'b0;//清空所有的控制信号
				end
			else
				begin
					{o_WB,o_M,o_EX,o_Rs,o_Rt,o_imm16,o_BusA,o_BusB,o_Rd,o_func} <= ID_EX_reg;
				end	
		end
endmodule