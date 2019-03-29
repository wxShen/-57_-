module im_4k (addr,dout);//指令寄存器（取指令）

input [11:2] addr;//address bus
output [31:0] dout;//32-bit memory output

reg [31:0] Im[1023:0];//4K的原因

integer i;
initial
	begin
		for(i=0;i<1024;i=i+1)
			Im[i] = 32'b0;
		$readmemh("Im_test.txt",Im);
	end

assign dout = Im[addr[11:2]];

endmodule