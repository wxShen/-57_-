module PC_tb ();
 
	reg [31:0] Npc;//下条指令的地址
	reg clk,Reset;//时钟，复位，功能信号定义
	wire[31:0] pc;//32位指令存储器地址(当然可以将最低2位省略)
initial begin
	Npc =32'h0000_3008;
	clk =0;
	Reset =0;
	#100;
	end
always #100 clk = ~clk;
always #100 Npc =Npc + 4;
 
PC Pc(Npc,clk,Reset,pc);
endmodule