`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:52:13 01/13/2016 
// Design Name: 
// Module Name:    pulse_jk_flipflop 
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
module pulse_jk_flipflop(
    input sw3_CLK,
	 input sw2_J,
	 input sw1_K,
	 output led8_Q
    );
	 wire s1_m,s2_m,s1_s,s2_s,temp_out1,temp_out2,temp_q;//temp_q即Q'
	 
	 assign s1_m = !(sw2_J & sw3_CLK & temp_q);
	 assign s2_m = !(sw1_K & sw3_CLK &  led8_Q);
	 assign s1_s = !(!sw3_CLK & temp_out1);
	 assign s2_s = !(!sw3_CLK & temp_out2);	 
    nand_rs_latch nand_rs_latch_m(.s1(s1_m),.s2(s2_m),.Q1(temp_out1),.Q2(temp_out2));
	 nand_rs_latch nand_rs_latch_s(.s1(s1_s),.s2(s2_s),.Q1(led8_Q),.Q2(temp_q));
	  
endmodule
//与非门实现的RS锁存器
module nand_rs_latch(
    input s1,
	 input s2,
	 output Q1,
	 output Q2
	 );	 
	 assign Q1 = !(s1&Q2);
	 assign Q2 = !(Q1&s2);
	
endmodule
