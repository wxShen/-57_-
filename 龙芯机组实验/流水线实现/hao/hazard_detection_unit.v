module pipeCtrl (EX_MemtoReg,Mem_MemtoReg,EX_rt,ID_rs,ID_rt,instr,branch,jump,ENwr,ctr_bubble,rst);

input EX_MemtoReg,Mem_MemtoReg,branch,jump;
input[4:0] EX_rt,ID_rs,ID_rt;
input[31:0] instr;  
output ENwr,ctr_bubble,rst;
wire R_type;
assign R_type = !(instr[31:26]);
assign ctr_bubble = (branch|jump) | (EX_MemtoReg & (ID_rs == EX_rt ))
	 | (EX_MemtoReg & (ID_rt == EX_rt ) & R_type) | ((Mem_MemtoReg|EX_MemtoReg) & branch) ;
assign ENwr = (EX_MemtoReg & (ID_rs == EX_rt )) | (EX_MemtoReg & (ID_rt == EX_rt ) & R_type) | ((Mem_MemtoReg|EX_MemtoReg) & branch);
assign rst = branch|jump; 

endmodule
