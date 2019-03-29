module im_4k(addr,dout);
	input [11:2] addr; 
	output [31:0] dout;
	reg[31:0] RAM[1023:0];
	integer i;
	initial
	begin
	for(i=0;i<1023;i=i+1)
	RAM[i]=32'b0;
	$readmemh("code.txt",RAM);
	end
	
	assign dout = RAM[addr[11:2]];
endmodule

