module im_tb ();
reg [11:2] addr;//address bus
wire [31:0] dout;//32-bit memory output

initial begin
	addr = 10'b0;
	#100;
end
always # 100 addr =addr + 1;
im_4k im(addr,dout);//指令寄存器（取指令）

endmodule