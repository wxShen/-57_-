
module RegFile(clk,RegWr,Rw,Ra,Rb,busW,busA,busB);
	input clk,RegWr;
	input[4:0] Rw,Ra,Rb;
	input[31:0] busW;
	output[31:0] busA,busB;

	reg[31:0] register[31:0];
	integer i;	
	initial  begin
	for(i=0;i<=31;i=i+1)
		register[i] = 32'h0000_0000;
	end

	assign busA = register[Ra];
	assign busB = register[Rb];

	always @(negedge clk) begin
		if(RegWr) begin
			register[Rw] <= busW;
		end
	end

endmodule

