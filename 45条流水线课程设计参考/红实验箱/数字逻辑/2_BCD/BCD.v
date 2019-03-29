`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:42:08 01/12/2016 
// Design Name: 
// Module Name:    BCD 
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
module BCD(
   input  [3:0] bcd_num,
	output [1:0] num1_scan_select,//选择FPGA_NUM1 7段数码管的扫描位
	output [7:0] num1_seg7			//FPGA_NUM1 7段数码管显示DP和a~g
    );
	assign num1_scan_select = 2'b10;
   assign num1_seg7=
	{bcd_num ==4'b0000}?8'b01111110 ://0
   {bcd_num ==4'b0001}?8'b00110000 ://1
	{bcd_num ==4'b0010}?8'b01101101 ://2
	{bcd_num ==4'b0011}?8'b01111001 ://3
	{bcd_num ==4'b0100}?8'b00110011 ://4
	{bcd_num ==4'b0101}?8'b01011011 ://5
	{bcd_num ==4'b0110}?8'b01011111 ://6
	{bcd_num ==4'b0111}?8'b01110000 ://7
	{bcd_num ==4'b1000}?8'b01111111 ://8
	{bcd_num ==4'b1001}?8'b01111011 ://9
	8'b01111011;//9
endmodule
