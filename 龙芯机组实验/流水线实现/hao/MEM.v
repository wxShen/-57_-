module MEM(clk,rst,busB,MemWr,MemtoReg,zero,rw,result,result2,WR_rw,WR_busW);
input clk,rst;
input [31:0] busB,result,WR_busW;
input [4:0] rw,WR_rw;
input MemWr,MemtoReg,zero;
output [31:0] result2;
wire ifEqual;
wire [31:0] temp;
assign ifEqual = (WR_rw == rw);
mux2 cmpBW(busB,WR_busW,ifEqual,temp);
dm_4k dm(result[11:2],temp,MemWr,clk,result2);
endmodule 
