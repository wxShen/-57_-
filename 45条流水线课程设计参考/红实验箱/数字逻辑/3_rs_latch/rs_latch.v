`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:37:52 01/13/2016 
// Design Name: 
// Module Name:    rs_latch 
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
module rs_latch(
    input sw2_R,
    input sw1_S,
    output led8_Q
    );
	 wire temp;
	 assign led8_Q = !(sw2_R | temp);
	 assign temp   = !(sw1_S | led8_Q);

endmodule
