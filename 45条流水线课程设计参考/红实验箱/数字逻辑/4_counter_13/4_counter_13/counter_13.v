`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:38:19 01/14/2016 
// Design Name: 
// Module Name:    counter_13 
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
module counter_13(
    input 			   button_clk,
	 input 				sw6_reset,
	 
	 output reg      	led8_C,
	 output reg[1:0] 	num1_scan_select,//选择FPGA_NUM1 7段数码管的扫描位
	 output    [7:0] 	num1_seg7			//FPGA_NUM1 7段数码管显示DP和a~g
    ); 

	 reg        Q3,Q2,Q1,Q0;
	 wire [3:0] state_num;	 

	 always @(posedge button_clk ) begin
	    if(sw6_reset) begin
		     Q3 <= 1'b0;
			  Q2 <= 1'b0;
			  Q1 <= 1'b0;
			  Q0 <= 1'b0;		  
			  num1_scan_select <= 2'b11;//不选 
			  led8_C 			 <= 1'b0;
		 end 
		 else begin
		     Q3 <=  Q3&!Q2 | Q2&Q1&Q0;
			  Q2 <= !Q3&Q2&!Q1 | !Q3&Q2&!Q0 | !Q2&Q1&Q0;
			  Q1 <= !Q1&Q0 | Q1&!Q0;
			  Q0 <= !Q3&!Q0 | !Q2&!Q0;			  
			  led8_C <= (state_num == 4'b1100)?1'b1:1'b0;			  
			  num1_scan_select <= 2'b10;//选择显示的数码管
		 end//else
	 end//always
	 //--------------display-------------------------
	 assign state_num	= {Q3,Q2,Q1,Q0}; //采集电路内部状态	

    assign num1_seg7=
	 {state_num ==4'b0000}?8'b01111110 ://0
    {state_num ==4'b0001}?8'b00110000 ://1
	 {state_num ==4'b0010}?8'b01101101 ://2
	 {state_num ==4'b0011}?8'b01111001 ://3
	 {state_num ==4'b0100}?8'b00110011 ://4
	 {state_num ==4'b0101}?8'b01011011 ://5
	 {state_num ==4'b0110}?8'b01011111 ://6
	 {state_num ==4'b0111}?8'b01110000 ://7
	 {state_num ==4'b1000}?8'b01111111 ://8
	 {state_num ==4'b1001}?8'b01111011 ://9
	 {state_num ==4'b1010}?8'b01110111 ://10 A
	 {state_num ==4'b1011}?8'b00011111 ://11 b
	 {state_num ==4'b1100}?8'b01001110 ://12 C
	 8'b01001110;//12
endmodule
   
