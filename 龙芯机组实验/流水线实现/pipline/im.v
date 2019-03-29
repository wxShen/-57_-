module im(addr,dout);//????????????2-11?
	input[11:2] addr;
	output [31:0] dout;
	reg[31:0] im[1023:0];

	initial $readmemh("code.txt",im);

	assign dout = im[addr];
endmodule
