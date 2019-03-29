/*PC主要功能是完成输出当前指令地址并保存下一条指令地址。
复位后，PC指向0x0000_3000，此处为第一条指令的地址。*/
`define PC_Initial 32'h0000_0034
module PC (clk,Reset,addr_in,addr_out);
	input [31:0] addr_in;//下条指令的地址
	input clk,Reset;//时钟，复位，功能信号定义
	output reg[31:0] addr_out;//32位指令存储器地址(当然可以将最低2位省略)

	initial 
		begin
			addr_out = `PC_Initial;
		end
	always @(negedge clk) 
		begin
			addr_out <= (Reset==1) ? `PC_Initial : addr_in;
		end
endmodule