`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:06:09 06/18/2017
// Design Name:   alu_display
// Module Name:   C:/Users/CSLab/Desktop/4_alu/test.v
// Project Name:  alu
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: alu_display
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test;

	// Inputs
	reg clk;
	reg resetn;
	reg [2:0] input_sel;

	// Outputs
	wire lcd_rst;
	wire lcd_cs;
	wire lcd_rs;
	wire lcd_wr;
	wire lcd_rd;
	wire lcd_bl_ctr;
	wire ct_scl;
	wire ct_rstn;

	// Bidirs
	wire [15:0] lcd_data_io;
	wire ct_int;
	wire ct_sda;

	// Instantiate the Unit Under Test (UUT)
	alu_display uut (
		.clk(clk), 
		.resetn(resetn), 
		.input_sel(input_sel), 
		.lcd_rst(lcd_rst), 
		.lcd_cs(lcd_cs), 
		.lcd_rs(lcd_rs), 
		.lcd_wr(lcd_wr), 
		.lcd_rd(lcd_rd), 
		.lcd_data_io(lcd_data_io), 
		.lcd_bl_ctr(lcd_bl_ctr), 
		.ct_int(ct_int), 
		.ct_sda(ct_sda), 
		.ct_scl(ct_scl), 
		.ct_rstn(ct_rstn)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		resetn = 0;
		input_sel = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

