module EX_MEM(clk,rst,
		busB,RegWr,MemWr,MemtoReg,zero,rw,result,
		busB2,RegWr2,MemWr2,MemtoReg2,zero2,rw2,result2);
input clk,rst;
input [31:0] busB,result;
input [4:0] rw;
input MemWr,MemtoReg,RegWr,zero;
output reg [31:0] busB2,result2;
output reg [4:0] rw2;
output reg MemWr2,MemtoReg2,RegWr2,zero2;
	initial begin
		rw2 = 0;
		busB2 = 0;
		MemWr2 = 0;
		MemtoReg2 = 0;
		RegWr2 = 0;
		zero2=0;
		result2=0;

	end

	always @(negedge clk) begin
		if (rst) begin
			rw2 <= 0;
			busB2 <= 0;
			MemWr2 <= 0;
			MemtoReg2 <= 0;
			RegWr2<=0;
			zero2 <= 0;
			result2 <= 0;
		end
		else begin
			rw2 <= rw;
			busB2 <= busB;
			MemWr2 <= MemWr;
			MemtoReg2 <= MemtoReg;
			RegWr2<=RegWr;
			zero2 <= zero;
			result2 <= result;
		end
	end
endmodule
