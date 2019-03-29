`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:56:17 01/13/2016 
// Design Name: 
// Module Name:    edge_t_flipflop 
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
module edge_t_flipflop(
    input  sw1_t,
	 input  clk,
	 //input  sw3_reset,
	 output reg led8_Q
    );
	 reg [24:0] count;
	 parameter COUNTER_SUM = 25'd16500000;   //33MHz¡£
    always @(posedge clk)begin
	   /*if(sw3_reset) begin
		      count <= 25'd0;
				led8_Q <= 1'b0;
		end 
		else */if(count<COUNTER_SUM)begin
			   count <= count + 25'd1;
		end 
		else begin
		      led8_Q <= sw1_t&!led8_Q | !sw1_t&led8_Q;
		      count <= 25'd0;
		end
	  end
    
endmodule
