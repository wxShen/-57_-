module HaDectUnit(Rs,Rt,Rw1,Rw2,RegWr1,MemtoReg1,MemtoReg2,loaduseHD,branchHD);
	input[4:0] Rs,Rt,Rw1,Rw2;
	input RegWr1,MemtoReg1,MemtoReg2;
	output loaduseHD,branchHD;

	assign loaduseHD = MemtoReg1 & ((Rs == Rw1) | (Rt == Rw1));

	assign branchHD = (RegWr1 & ((Rs == Rw1) | (Rt == Rw1))) | (MemtoReg2 & ((Rs == Rw2) | (Rt == Rw2)));

endmodule