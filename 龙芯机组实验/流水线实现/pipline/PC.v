module PC(clk,rst,address_in,address_out);
	input clk,rst;
	input[31:0] address_in;
	output[31:0] address_out;
	reg[31:0] address_out;

	initial begin
		address_out = 32'h00003000; 
	end

	always @(negedge clk) begin
		if (rst) begin
			address_out = 32'h00003000;
		end
		else begin
			address_out <= address_in;
		end
	end


endmodule