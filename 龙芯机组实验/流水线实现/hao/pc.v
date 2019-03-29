module PC(clk,rst,ENwr,din,dout);
	input clk,rst,ENwr;
	input[31:0] din;
	output [31:0] dout;
	reg [31:0] dout;
	initial begin
		dout =  32'h3000;
	end

	always @(negedge clk) begin
		if (rst) begin
			dout <= 32'h3000;
		end
		else if (!ENwr)begin
			dout <= din;
		end
	end
endmodule

