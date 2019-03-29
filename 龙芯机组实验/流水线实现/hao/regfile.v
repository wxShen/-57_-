module regfile(clk,RegWr,rs,rt,rd,busW,busA,busB);
	input clk;
 	input RegWr;		
	input [4:0] rs, rt, rd;		
	input [31:0] busW;			
	output [31:0] busA, busB;	
	reg [31:0] regfile [31:0];
	integer i;
	initial
		begin
		for(i=0;i<32;i=i+1)
			regfile[i]=32'b0;
		end
	assign busA = (rs != 0)? regfile[rs]:0;
	assign busB = (rt != 0)? regfile[rt]:0;
	always @(posedge clk )
		if(RegWr)regfile[rd] <= busW;

	
endmodule

