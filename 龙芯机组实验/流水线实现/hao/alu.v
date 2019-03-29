`include "mux2.v"
module ALU(a, b, op, zero, result);

input [31:0] a,b;
input [2:0] op;
output reg [31:0] result;
output zero;
wire SUBctr,addcarry;
wire[1:0] OPctr;
wire[31:0] result1,result2,result3;

assign SUBctr = op[2];
assign OPctr[1] = op[2]&op[1];
assign OPctr[0] = !op[2]&op[1]&!op[0];
assign zero = (result == 0) ? 1 : 0;
addu ADDU(.a(a),.b(b),.SUBctr(SUBctr),.result(result1),.addcarry(addcarry));
ori ORI(.a(a),.b(b),.result(result2));
slt SLT(.a(a),.b(b),.SUBctr(SUBctr),.result(result3),.addcarry(addcarry)) ;
always @ (OPctr or a or b)
	begin
		case(OPctr)
			2'b00:result = result1;
			2'b01:result = result2;
			2'b10:result = result3;
		endcase
	end
endmodule

module signext(cin,extcin);
input  cin; 
output [31:0] extcin;
	
	assign extcin = {{31{cin}}, cin};
	
endmodule

module addu(a,b,SUBctr,result,addcarry);
input [31:0] a,b;
input SUBctr;
output[31:0] result;
output addcarry;
wire[31:0] negcode,c;
wire[32:0] tempResult;
signext SIGNEXT(.cin(SUBctr),.extcin(negcode));
assign c=b^negcode;
assign tempResult=a+c+SUBctr;
assign addcarry = tempResult[32];
assign result = tempResult[31:0];
endmodule

module ori(a,b,result);
input[31:0] a,b;
output[31:0] result;
assign result=a|b;
endmodule

module slt(a,b,SUBctr,result,addcarry);
input[31:0] a,b;
input SUBctr;
input addcarry;
output[31:0] result;
wire[31:0] d0,d1,temp;
wire pa;
addu ADDU1(.a(a),.b(b),.SUBctr(SUBctr),.result(temp),.addcarry(addcarry));
assign d0=31'b0;
assign d1=31'b1;
assign pa = addcarry^SUBctr;
mux2 mux2_1(.d0(d0), .d1(d1), .s(pa), .y(result));

endmodule

