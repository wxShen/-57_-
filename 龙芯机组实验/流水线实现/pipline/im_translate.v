module im_translate(dout,Rs,Rt,Rd,imm16,target26);
	input[31:0] dout;
	output[4:0] Rs,Rt,Rd;
	output[15:0] imm16;
	output[25:0] target26;


	assign Rs = dout[25:21];
	assign Rt = dout[20:16];
	assign Rd = dout[15:11];
	assign imm16 = dout[15:0];
	assign target26 = dout[25:0];
endmodule