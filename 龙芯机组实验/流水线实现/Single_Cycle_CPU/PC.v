/*PC主要功能是完成输出当前指令地址并保存下一条指令地址。
复位后，PC指向0x0000_3000，此处为第一条指令的地址。*/
`define PC_Initial 32'h0000_3000
module PC (Npc,clk,Reset,pc);
	input [31:0] Npc;//下条指令的地址
	input clk,Reset;//时钟，复位，功能信号定义
	output reg[31:0] pc;//32位指令存储器地址(当然可以将最低2位省略)

	initial 
		begin
			pc = `PC_Initial;
		end
	always @(posedge clk) 
		begin
			pc <= (Reset==1) ? `PC_Initial : Npc;
		end
endmodule