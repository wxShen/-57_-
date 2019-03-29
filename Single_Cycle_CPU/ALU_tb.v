`include "ALU.v"
module ALU_tb ();
	reg [2:0] ALUctr;
	reg [31:0] A;
	reg [31:0] B;
	wire Zero,Overflow;
	wire [31:0] Result;

	initial begin
		ALUctr =3'b0;
		A = 32'b0;
		B =32'b0;
		#100;
	end

	always  #100 ALUctr = (ALUctr + 1) % 8 ;
	always  #100 A = A +1;	
	always  #100 B = B +1;

	ALU #32 alu(.ALUctr(ALUctr),.A (A),.B (B),.Zero(Zero),.Overflow(Overflow));

endmodule