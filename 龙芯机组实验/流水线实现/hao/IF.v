module IF(clk,rst,ENwr,din,instr_branch,instr_jump,ctr_branch,jump,dout,instr,nextAddr);
input clk,rst,jump,ctr_branch,ENwr;
input[31:0] din,instr_branch,instr_jump;
output [31:0] dout,instr,nextAddr;
wire [31:0] instr_temp,dout2;
IUnit iunit(clk,rst,ENwr,din,dout,instr);	
assign dout2 = dout;
mux2 MUX_branch (dout2, instr_branch, ctr_branch, instr_temp);		
mux2 MUX_jump(instr_temp, instr_jump, jump, nextAddr);
endmodule

module IUnit(clk,rst,ENwr,din,dout,instr);

input clk,rst,ENwr;
input[31:0] din;
output [31:0] dout,instr;
wire [31:0] dout2;
PC pc(clk,rst,ENwr,din,dout2);
im_4k im(din[11:2],instr);
assign dout = din + 4;

endmodule
