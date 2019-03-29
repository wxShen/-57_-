module NPC_tb ();

	reg [15:0] imm16;    // 立即数
	reg Branch,Zero,Jump; // 跳转指令，以及zero信号
	reg [31:0] pc;  //当前pc的值
	reg [25:0] Target;
	wire [31:0] npc ;

	initial begin
		imm16 = 16'b1000_0000;
		Branch <= 0;
		Zero <=1;
		Jump <=0;
		#100;
	end

	always #100 Jump = ~ Jump;
	always #100 Branch = ~ Branch;
	NPC Npc(imm16,Branch,Zero,Jump,pc,Target,npc);


endmodule