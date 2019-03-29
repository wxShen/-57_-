module ctrl(dout,Branch,Jump,RegDst,ALUSrc,ALUctr,MemtoReg,RegWr,MemWr,Extop);
	input[31:0] dout;
	output Branch,Jump,RegDst,ALUSrc,MemtoReg,RegWr,MemWr,Extop;
	output[2:0] ALUctr;

	wire [5:0]  Op, func;
	wire [2:0]	ALUop_1, ALUop_2;
	
	assign Op = dout[31:26];
	assign func = dout[5:0];

	wire ori, addiu, lw, sw, beq, j;
	wire R_type;

	assign R_type = ~Op[5] & ~Op[4] & ~Op[3] & ~Op[2] & ~Op[1] & ~Op[0];
	assign ori   = ~Op[5] & ~Op[4] &  Op[3] &  Op[2] & ~Op[1] &  Op[0];
	assign addiu = ~Op[5] & ~Op[4] &  Op[3] & ~Op[2] & ~Op[1] &  Op[0];
	assign lw    =  Op[5] & ~Op[4] & ~Op[3] & ~Op[2] &  Op[1] &  Op[0];
	assign sw    =  Op[5] & ~Op[4] &  Op[3] & ~Op[2] &  Op[1] &  Op[0];
	assign beq   = ~Op[5] & ~Op[4] & ~Op[3] &  Op[2] & ~Op[1] & ~Op[0];
	assign j     = ~Op[5] & ~Op[4] & ~Op[3] & ~Op[2] &  Op[1] & ~Op[0];

	assign Branch = beq;
	assign Jump = j;
	assign RegDst = R_type;
	assign ALUSrc = ori | addiu | lw | sw;
	assign MemtoReg = lw;
	assign RegWr = R_type | ori | addiu | lw;
	assign MemWr = sw;
	assign Extop = addiu | lw | sw; 

	assign ALUop_1[2] = beq; 
	assign ALUop_1[1] = ori;
	assign ALUop_1[0] = R_type;

	assign ALUop_2[2] = ~func[2] & func[1];
	assign ALUop_2[1] = func[3] & ~func[2] & func[1];
	assign ALUop_2[0] = ~func[3] & ~func[2] & ~func[1] & ~func[0] + ~func[2] & func[1] & ~func[0];

	assign ALUctr = (R_type == 1) ? ALUop_2 : ALUop_1;

endmodule









