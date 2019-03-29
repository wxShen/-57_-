`include "im.v"

module IUnit(address_in,ins,address_out); //address_out 为PC+4
	input[31:0] address_in;
	output[31:0] ins,address_out;

	im im_1(.addr(address_in[11:2]),.dout(ins));
	assign address_out = address_in + 4;
endmodule