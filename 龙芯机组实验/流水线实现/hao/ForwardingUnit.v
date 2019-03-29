module ForwardUnit(rs,rt,EX_MEM_rd,MEM_WR_rd,EX_MEM_RegWr,MEM_WR_RegWr,ForwardA,ForwardB,ALUSrc);

input [4:0] rs,rt,EX_MEM_rd,MEM_WR_rd;
input EX_MEM_RegWr,MEM_WR_RegWr,ALUSrc;
output [1:0] ForwardA,ForwardB;
wire a1,a2,b1,b2;
assign a1 = (MEM_WR_RegWr & MEM_WR_rd) ;
assign a2 =  (MEM_WR_rd == rt);
assign b1 = (EX_MEM_RegWr & EX_MEM_rd) ;
assign b2 = (EX_MEM_rd == rt);
assign ForwardA[0] = ((MEM_WR_RegWr && MEM_WR_rd) && (MEM_WR_rd == rs) && !((EX_MEM_RegWr && EX_MEM_rd) && (EX_MEM_rd == rs)));
assign ForwardA[1] = ((EX_MEM_RegWr && EX_MEM_rd) && (EX_MEM_rd == rs));
assign ForwardB[0] = ((MEM_WR_RegWr && MEM_WR_rd) && (MEM_WR_rd == rt)  && !((EX_MEM_RegWr && EX_MEM_rd) && (EX_MEM_rd == rt)))
		||(!((MEM_WR_RegWr && MEM_WR_rd) && (MEM_WR_rd == rt)  && !((EX_MEM_RegWr && EX_MEM_rd) && (EX_MEM_rd == rt)))&& ALUSrc );
assign ForwardB[1] = ((EX_MEM_RegWr && EX_MEM_rd) && (EX_MEM_rd == rt)) || (!((EX_MEM_RegWr && EX_MEM_rd) && (EX_MEM_rd == rt)) && ALUSrc) ;
endmodule
