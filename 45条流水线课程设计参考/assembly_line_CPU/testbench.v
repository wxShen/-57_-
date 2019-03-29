module testbench();
	reg clk,rst;
	initial 
		begin
		    clk = 1;
		    rst = 0;
		    #35 rst = 1;
		    #10 rst = 0;
		end
	always #50 clk = ~clk;
	Datapath datapath(clk,rst);
endmodule