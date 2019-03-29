`include "mux2.v"
module ALUctr(op,func,ALUc);

input[31:26] op;
input[5:0] func;
output [2:0] ALUc;
wire[2:0] ALUop,ALUtem;
wire[31:0] d0,d1,d;
wire zero;
assign ALUop[2]=!op[31]&!op[30]&!op[29]&op[28]&!op[27]&!op[26];
assign ALUop[1]=!op[31]&!op[30]&op[29]&op[28]&!op[27]&op[26];
assign ALUop[0]=!op[31]&!op[30]&!op[29]&!op[28]&!op[27]&!op[26];
assign ALUtem[0]=!func[3]&!func[2]&!func[1]&!func[0]+!func[2]&func[1]&!func[0];
assign ALUtem[1]=func[3]&!func[2]&func[1];
assign ALUtem[2]=!func[2]&func[1];
assign zero = 1'b0;
assign d0 = {{29{zero}},ALUop};
assign d1 = {{29{zero}},ALUtem};
mux2 MUX_2(.d0(d0),.d1(d1),.s((!op[31]&!op[30]&!op[29]&!op[28]&!op[27]&!op[26])),.y(d));
assign ALUc = d[2:0];

endmodule
