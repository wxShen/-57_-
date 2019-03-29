`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:14:00 06/18/2017
// Design Name:   alu
// Module Name:   C:/Users/CSLab/Desktop/4_alu/testbench.v
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
	reg [63:0] alu_src1;
	reg [63:0] alu_src2;

	// Outputs
	wire [63:0] alu_result;

	// Instantiate the Unit Under Test (UUT)
	alu uut (
		.alu_control(alu_control), 
		.alu_src1(alu_src1), 
		.alu_src2(alu_src2), 
		.alu_result(alu_result)
	);

	initial begin
		// Initialize Inputs
		alu_control = 12'h800;
		alu_src1 = 0;
		alu_src2 = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
	always #100 alu_src1 = $random;
	always #100 alu_src2 = $random;
	
endmodule

