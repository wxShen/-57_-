`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:39:15 06/19/2017 
// Design Name: 
// Module Name:    testbench 
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
module testbench();

	reg clk;
	reg mult_begin;
	reg[31:0] mult_op1;
	reg[31:0] mult_op2;
	wire [63:0] product;
	wire mult_end;
	
	multiply mul(clk,mult_begin,mult_op1,mult_op2,product,mult_end);
	
	initial
	begin
		clk = 0;
		mult_begin = 1;
		mult_op1 = 32'h0000_0009;
		mult_op2 = 32'h0000_0005;
	end
	

endmodule
