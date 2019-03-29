module IF_ID(din,instr,dout,nextinstr,clk,rst,ENwr);
	input clk,rst,ENwr;
	input[31:0] din,instr;
	output [31:0] dout,nextinstr;
	reg [31:0] dout,nextinstr;
	initial begin
		dout =  32'h3000;
		nextinstr = 32'b0;
	end
	always @ (negedge clk)begin
		if (rst) begin
			dout <= 32'h3000;
			nextinstr<=32'b0;
		end
		else if(!ENwr) begin
			dout <= din;
			nextinstr <= instr;
		end
	end
endmodule
