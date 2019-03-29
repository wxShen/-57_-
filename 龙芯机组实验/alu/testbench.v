`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:46:05 06/16/2017
// Design Name:   alu
// Module Name:   D:/Longxin/alu/testbench.v
// Project Name:  alu
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: alu
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
	reg [11:0] alu_control;
	reg [31:0] alu_src1;
	reg [31:0] alu_src2;

	// Outputs
	wire [31:0] alu_result;

	// Instantiate the Unit Under Test (UUT)
	alu uut (
		.alu_control(alu_control), 
		.alu_src1(alu_src1), 
		.alu_src2(alu_src2), 
		.alu_result(alu_result)
	);

	initial begin
		// Initialize Inputs
		alu_control = 12'b0000_0000_0001;
		alu_src1 = 0;
		alu_src2 = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
	
	 always #10 alu_control = alu_control * 2;
	 always #10 alu_src1 = alu_src1 + 1;
	 always #10 alu_src2 = alu_src2 + 2;

endmodule

