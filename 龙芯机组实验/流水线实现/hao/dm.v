module dm_4k(addr, din, we, clk, dout);
	input clk, we;
	input [11:2] addr;
	input [31:0] din;
	output [31:0] dout;
	reg[31:0] dRAM[1023:0];
	integer i;
	initial
		begin
		for(i=0;i<1023;i=i+1)
			dRAM[i]=32'b0;
		end
	assign dout = dRAM[addr[11:2]]; 
	
	always @(posedge clk)
		if(we)
			dRAM[addr[11:2]] <= din;

endmodule

