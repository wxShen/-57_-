module IUnit (addr_in,instruction,pc_plus_4);
	input[31:0] addr_in;
	output [31:0] instruction,pc_plus_4;

	im_4k im(.addr(addr_in[11:2]),.dout(instruction));
	assign pc_plus_4 = addr_in + 4;
	
endmodule