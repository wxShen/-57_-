module MEM_WR(clk,rst,result,result2,RegWr,RegWr2,outResult,outResult2,MemtoReg,MemtoReg2,rw,rw2);
input clk,rst;
input [31:0] result,result2;
input [4:0] rw;
input MemtoReg,RegWr;
output reg [31:0] outResult,outResult2;
output reg [4:0] rw2;
output reg MemtoReg2,RegWr2;
	initial begin
		rw2 = 0;
		outResult = 0;
		outResult2 = 0;
		MemtoReg2 = 0;
		RegWr2 = 0;
	end

	always @(negedge clk) begin
		if (rst) begin
			rw2 <= 0;
			outResult <= 0;
			outResult2 <= 0;
			MemtoReg2 <= 0;
			RegWr2<=0;
		end
		else begin
			rw2 <= rw;
			outResult <= result;
			outResult2 <= result2;
			MemtoReg2 <= MemtoReg;
			RegWr2<=RegWr;
		end
	end
endmodule
