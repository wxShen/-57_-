module Ext_tb ();

	reg Op;
	reg [15:0] in;
	wire [32:0] out;

	initial begin
		Op = 0;
		#10 Op = ~Op;
		in =16'b0;
	end

	always # 100 in =in + 1;
    ext #(16,32) Ext(Op,in,out);
endmodule