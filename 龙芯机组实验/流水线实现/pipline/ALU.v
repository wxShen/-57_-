module ALU(a,b,ALUctr,result,zero);
	input[31:0] a,b;
	input[2:0] ALUctr;
	output [31:0] result;
	output  zero;

	reg[31:0] result;
	assign zero = (result == 0)? 1:0;
	wire[31:0] sub = a - b;
	always @(ALUctr or a or b)
	begin 
		case(ALUctr)
		3'b000: result = a + b;
		3'b001: result = a + b;
		3'b010: result = a | b;
		3'b100: result = a - b;
		3'b101: result = a - b;
		3'b110: result = (a<b) ? 1:0;
		3'b111: result = (a<b) ? 1:0;
		endcase
	end
endmodule
