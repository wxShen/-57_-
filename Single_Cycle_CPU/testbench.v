module testbench();
	reg clk,rst;
	initial 
		begin
		    clk = 0;
		    rst = 0;
		    #45 rst = 1;
		    #10 rst = 0;
		end
	always #50 clk = ~clk;
	mips mips(clk,rst);
endmodule