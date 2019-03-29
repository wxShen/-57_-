`include "mips.v"

module test_cpu();
	
	reg	clk,rst;
	
	initial begin
	clk = 1;
	rst = 1;
	#120 rst = 0;
	forever #100  clk = ~clk;
	end

	mips my_mips(.clk(clk), .rst(rst));

endmodule