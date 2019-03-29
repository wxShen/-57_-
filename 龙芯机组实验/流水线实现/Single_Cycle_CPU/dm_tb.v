module dm_tb ();

	reg [11:2] addr;		//address bus
	reg [31:0] din;		//32-bit input data
	wire MemWr;				//memory write enable
	reg clk;				//clock
	wire [31:0] dout;		//32-bit memory output

	initial begin
		clk = 0;
		addr = 10'b00000_00000;
		din =32'b1;
		#100 clk =1;
	end

	always #100 addr =addr + 1;		 
	always #100 din = din + 1;
	always #100 clk = ~clk;
	dm_4k dm(addr,din,MemWr,clk,dout);//数据存储器
endmodule
