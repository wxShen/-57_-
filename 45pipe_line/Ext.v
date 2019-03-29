//32位符号拓展
module Sign_Ext #(parameter WIDTH =16)(
	input [WIDTH-1:0] in,
	output [31:0] out
	);

assign out ={{32-WIDTH{in[WIDTH-1]}},in};

endmodule

module Zero_Ext #(parameter WIDTH =16)(
	input [WIDTH-1:0] in1,
	output [31:0] out1
);

assign out1 ={{32-WIDTH{1'b0}},in1};

endmodule

module Ext #(parameter WIDTH = 16)(
	input ExtOP,
	input [WIDTH-1:0] in2,
	output [31:0] out2
);

	wire [WIDTH-1 : 0] Sign_Ext,Zero_Ext;

	Sign_Ext #32 sign(.in (in2),.out(Sign_Ext));
	Zero_Ext #32 zero(.in1 (in2),.out1(Zero_Ext));

 	Mux_2_To_1_Width #32 Ext_Mux(.i_Select(ExtOP),.i_Data1 (Zero_Ext),
 							.i_Data2 (Sign_Ext),.o_Data(out2));
 endmodule


module sign_extend
        #(parameter INWIDTH = 16,OUTWIDTH=32)
        (in,out);
    input  [ INWIDTH-1:0] in;
    output [OUTWIDTH-1:0] out;
    assign out = {{OUTWIDTH-INWIDTH{in[INWIDTH-1]}}, in};
endmodule

module zero_extend
        #(parameter INWIDTH = 16,OUTWIDTH=32)
        (in,out);
    input  [ INWIDTH-1:0] in;
    output [OUTWIDTH-1:0] out;
    assign out = {{OUTWIDTH-INWIDTH{1'b0}}, in};
endmodule

module ext
        #(parameter IN = 16,OUT=32)
        (Op,in,out);

    input  wire   Op; 
    input  [ IN-1:0] in;
    output [OUT-1:0] out;
    
    wire [OUT-1:0] sign_in;
    wire [OUT-1:0] zero_in;

    sign_extend #(IN,OUT) sign_extend(in,sign_in);// * 0 for zero_extend
                                                 //* 1 for sign_extend
    zero_extend #(IN,OUT) zero_extend(in,zero_in);
    
    Mux_2_To_1_Width #32 Ext_Mux(.i_Select(Op),.i_Data1 (zero_in),
 							.i_Data2 (sign_in),.o_Data(out));
endmodule