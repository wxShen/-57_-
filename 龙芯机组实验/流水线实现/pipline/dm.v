module dm(addr,din,we,clk,dout); //????2-11?
	input[11:2] addr ;
	input[31:0] din ;
	input we ;
	input clk ;
	output[31:0] dout ;
	reg[31:0] dm[1023:0];

	assign dout = dm[addr];
	integer i;
	initial begin
	for(i=0;i<=1023;i=i+1)
		dm[i] = 0;
	end

	always @(negedge clk) begin
		if(we) begin
			dm[addr] <= din;
		end
	end

endmodule
