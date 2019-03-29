
module Mux2_32(d0,d1,s,y);
	input[31:0] d0,d1;
	input s;
	output[31:0] y;
	assign y = (s==0)? d0 : d1;
endmodule

module Mux4_32(d0,d1,d2,d3,s,y);
	input[31:0] d0,d1,d2,d3;
	input[1:0] s;
	output[31:0] y;
	wire[31:0] y1,y2;
	Mux2 mux2_1(d0,d1,s[0],y1);
	Mux2 mux2_2(d2,d3,s[0],y2);
	Mux2 mux2_3(y1,y2,s[1],y);
	//??????mux????
endmodule

module Mux2_30(d0,d1,s,y);
	input[29:0] d0,d1;
	input s;
	output[29:0] y;
	assign y = (s==0)? d0 : d1;
endmodule


module Mux2_5(d0,d1,s,y);
	input[4:0] d0,d1;
	input s;
	output[4:0] y;
	assign y = (s==0)? d0 : d1;
endmodule
