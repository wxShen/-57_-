`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:21:47 06/16/2017
// Design Name:   regfile
// Module Name:   D:/Longxin/regfile/testbench.v
// Project Name:  regfile
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: regfile
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module testbench;

	// Inputs
	reg clk;
	reg wen;
	reg [4:0] raddr1;
	reg [4:0] raddr2;
	reg [4:0] waddr;
	reg [31:0] wdata;
	reg [4:0] test_addr;

	// Outputs
	wire [31:0] rdata1;
	wire [31:0] rdata2;
	wire [31:0] test_data;

	// Instantiate the Unit Under Test (UUT)
	regfile uut (
		.clk(clk), 
		.wen(wen), 
		.raddr1(raddr1), 
		.raddr2(raddr2), 
		.waddr(waddr), 
		.wdata(wdata), 
		.rdata1(rdata1), 
		.rdata2(rdata2), 
		.test_addr(test_addr), 
		.test_data(test_data)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		wen = 0;
		raddr1 = 0;
		raddr2 = 0;
		waddr = 0;
		wdata = 0;
		test_addr = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

