`include "datapath.v"

module mips(rst,clk);
	input rst,clk;
	datapath datapath_1(clk,rst);
endmodule