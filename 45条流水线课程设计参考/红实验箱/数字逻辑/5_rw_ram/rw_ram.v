`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:55:24 01/14/2016 
// Design Name: 
// Module Name:    rw_ram 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module rw_ram(
    input 			  row1_clk,
	 
    input           u9sw6_ram_en,	//RAM使能
	 input           u9sw5_r_en,		//读使能
	 input     [1:0] u10_addr,			//4个地址,U10单元的{sw2,sw1}
	 input     [3:0] data_in,			//4位数据输入U10单元的{sw6,sw5,sw4,sw3}
	 
	 output    [3:0]  data_out_led,	//最右边4个led：{led13,led1,led2,led3} 
	 output    [3:0]  col1_4,
	 output    [1:0] 	num1_scan_select,//选择FPGA_NUM1 7段数码管的扫描位
	 output    [7:0] 	num1_seg7			//FPGA_NUM1 7段数码管显示DP和a~g
    );
	 reg[3:0] ram[3:0];//4行，每行4位
	 reg[3:0] data_out;
	 
    always @(posedge row1_clk)
	 begin
	     if(u9sw6_ram_en)//RAM使能
		  begin
		      if(u9sw5_r_en)//读数据
				begin
		          data_out <=ram[u10_addr];
				end//if
				else begin //写数据
				    ram[u10_addr]<=data_in;
				end
		  end//if
	 end//always
    //----------check the key:col1row1----------
	 assign col1_4 = 4'b0111;
	 assign data_out_led = ~data_out;//灯亮为1，灯灭为0	 
	 assign num1_scan_select = 2'b10;//选择显示的数码管
	 
	 assign num1_seg7=
	 {(data_in ==4'b0000)&!u9sw5_r_en|(data_out ==4'b0000)&u9sw5_r_en}?8'b01111110 ://0
    {(data_in ==4'b0001)&!u9sw5_r_en|(data_out ==4'b0001)&u9sw5_r_en}?8'b00110000 ://1
	 {(data_in ==4'b0010)&!u9sw5_r_en|(data_out ==4'b0010)&u9sw5_r_en}?8'b01101101 ://2
	 {(data_in ==4'b0011)&!u9sw5_r_en|(data_out ==4'b0011)&u9sw5_r_en}?8'b01111001 ://3
	 {(data_in ==4'b0100)&!u9sw5_r_en|(data_out ==4'b0100)&u9sw5_r_en}?8'b00110011 ://4
	 {(data_in ==4'b0101)&!u9sw5_r_en|(data_out ==4'b0101)&u9sw5_r_en}?8'b01011011 ://5
	 {(data_in ==4'b0110)&!u9sw5_r_en|(data_out ==4'b0110)&u9sw5_r_en}?8'b01011111 ://6
	 {(data_in ==4'b0111)&!u9sw5_r_en|(data_out ==4'b0111)&u9sw5_r_en}?8'b01110000 ://7
	 {(data_in ==4'b1000)&!u9sw5_r_en|(data_out ==4'b1000)&u9sw5_r_en}?8'b01111111 ://8
	 {(data_in ==4'b1001)&!u9sw5_r_en|(data_out ==4'b1001)&u9sw5_r_en}?8'b01111011 ://9
	 {(data_in ==4'b1010)&!u9sw5_r_en|(data_out ==4'b1010)&u9sw5_r_en}?8'b01110111 ://10 A
	 {(data_in ==4'b1011)&!u9sw5_r_en|(data_out ==4'b1011)&u9sw5_r_en}?8'b00011111 ://11 b
	 {(data_in ==4'b1100)&!u9sw5_r_en|(data_out ==4'b1100)&u9sw5_r_en}?8'b01001110 ://12 C
	 {(data_in ==4'b1101)&!u9sw5_r_en|(data_out ==4'b1101)&u9sw5_r_en}?8'b00111101 ://13 d
	 {(data_in ==4'b1110)&!u9sw5_r_en|(data_out ==4'b1110)&u9sw5_r_en}?8'b01001111 ://14 E
	 {(data_in ==4'b1111)&!u9sw5_r_en|(data_out ==4'b1111)&u9sw5_r_en}?8'b01000111 ://15 F	 
	 8'b01000111;
endmodule


/*
assign num1_seg7={8{u9sw6_ram_en&u9sw5_r_en}}&num1_seg7_r |
	                  {8{u9sw6_ram_en&!u9sw5_r_en}}&num1_seg7_w ;
 assign num1_seg7_r=
	 {data_out ==4'b0000}?8'b01111110 ://0
    {data_out ==4'b0001}?8'b00110000 ://1
	 {data_out ==4'b0010}?8'b01101101 ://2
	 {data_out ==4'b0011}?8'b01111001 ://3
	 {data_out ==4'b0100}?8'b00110011 ://4
	 {data_out ==4'b0101}?8'b01011011 ://5
	 {data_out ==4'b0110}?8'b01011111 ://6
	 {data_out ==4'b0111}?8'b01110000 ://7
	 {data_out ==4'b1000}?8'b01111111 ://8
	 {data_out ==4'b1001}?8'b01111011 ://9
	 {data_out ==4'b1010}?8'b01110111 ://10 A
	 {data_out ==4'b1011}?8'b00011111 ://11 b
	 {data_out ==4'b1100}?8'b01001110 ://12 C
	 {data_out ==4'b1101}?8'b00111101 ://13 d
	 {data_out ==4'b1110}?8'b01001111 ://14 E
	 {data_out ==4'b1111}?8'b01000111 ://15 F	 
	 8'b01000111;*/