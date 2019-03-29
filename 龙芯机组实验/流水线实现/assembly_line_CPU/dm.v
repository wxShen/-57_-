module dm_4k(addr,din,MemWr,clk,dout);//数据存储器
	input [11:2] addr;		//address bus
	input [31:0] din;		//32-bit input data
	input MemWr;				//memory write enable
	input clk;				//clock
	output [31:0] dout;		//32-bit memory output

	reg[31:0] Dm[1023:0];
	integer i;
	initial
		begin
			for(i=0;i<1024;i=i+1)
				Dm[i] = 32'b0;
		end

	assign dout = Dm[addr[11:2]];//每条指令均为4个字节

	always @(posedge clk)//时钟上升沿到来时将数据写到内存中
		begin
			if(MemWr)
				Dm[addr[11:2]] <= din;
		end
endmodule // dm_4k