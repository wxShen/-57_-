module WR(clk,rst,result,result2,MemtoReg,rw,Di,busW);

input clk,rst,MemtoReg;
input [31:0] result,result2;
input [4:0] rw;
output[31:0] busW;
output [4:0] Di;
mux2  ALUToreg(result,result2,MemtoReg,busW);
assign Di=rw;
endmodule
