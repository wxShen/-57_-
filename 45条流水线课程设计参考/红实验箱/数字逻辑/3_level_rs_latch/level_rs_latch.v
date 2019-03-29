`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:27:01 01/13/2016 
// Design Name: 
// Module Name:    level_rs_latch 
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
module level_rs_latch(//电平触发的RS触发器
    input sw3_CLK,
    input sw2_R,
    input sw1_S,
    output led8_Q
    );
	 wire s1,s2;
	 assign s1 = !(sw3_CLK & sw1_S);
    assign s2 = !(sw3_CLK & sw2_R);
	 nand_rs_latch nand_rs_latch0(.s1(s1),.s2(s2),.Q(led8_Q));

endmodule
//与非门实现的RS锁存器
module nand_rs_latch(
    input s1,
	 input s2,
	 output Q
	 );
	 wire temp;
	 assign temp = !(Q&s2);
	 assign Q    = !(s1&temp);
	 
endmodule
