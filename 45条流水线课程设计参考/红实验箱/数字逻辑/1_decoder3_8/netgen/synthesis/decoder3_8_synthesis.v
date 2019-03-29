////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2012 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor: Xilinx
// \   \   \/     Version: P.40xd
//  \   \         Application: netgen
//  /   /         Filename: decoder3_8_synthesis.v
// /___/   /\     Timestamp: Tue Jan 12 21:24:52 2016
// \   \  /  \ 
//  \___\/\___\
//             
// Command	: -intstyle ise -insert_glbl true -w -dir netgen/synthesis -ofmt verilog -sim decoder3_8.ngc decoder3_8_synthesis.v 
// Device	: xc6slx150-3-fgg484
// Input file	: decoder3_8.ngc
// Output file	: D:\Users\decoder3_8\netgen\synthesis\decoder3_8_synthesis.v
// # of Modules	: 1
// Design Name	: decoder3_8
// Xilinx        : f:\Xilinx\14.3\ISE_DS\ISE\
//             
// Purpose:    
//     This verilog netlist is a verification model and uses simulation 
//     primitives which may not represent the true implementation of the 
//     device, however the netlist is functionally correct and should not 
//     be modified. This file cannot be synthesized and should only be used 
//     with supported simulation tools.
//             
// Reference:  
//     Command Line Tools User Guide, Chapter 23 and Synthesis and Simulation Design Guide, Chapter 6
//             
////////////////////////////////////////////////////////////////////////////////

`timescale 1 ns/1 ps

module decoder3_8 (
  Sw3_A2, Sw2_A1, Sw1_A0, LED3_Y0, LED2_Y1, LED1_Y2, LED13_Y3, LED12_Y4, LED11_Y5, LED10_Y6, LED9_Y7
);
  input Sw3_A2;
  input Sw2_A1;
  input Sw1_A0;
  output LED3_Y0;
  output LED2_Y1;
  output LED1_Y2;
  output LED13_Y3;
  output LED12_Y4;
  output LED11_Y5;
  output LED10_Y6;
  output LED9_Y7;
  wire Sw3_A2_IBUF_0;
  wire Sw2_A1_IBUF_1;
  wire Sw1_A0_IBUF_2;
  wire LED2_Y1_OBUF_3;
  wire LED13_Y3_OBUF_4;
  wire LED11_Y5_OBUF_5;
  wire LED9_Y7_OBUF_6;
  wire LED12_Y4_OBUF_7;
  wire LED10_Y6_OBUF_8;
  wire LED1_Y2_OBUF_9;
  wire LED3_Y0_OBUF_10;
  LUT3 #(
    .INIT ( 8'h02 ))
  LED2_Y11 (
    .I0(Sw1_A0_IBUF_2),
    .I1(Sw3_A2_IBUF_0),
    .I2(Sw2_A1_IBUF_1),
    .O(LED2_Y1_OBUF_3)
  );
  LUT3 #(
    .INIT ( 8'h20 ))
  LED13_Y31 (
    .I0(Sw1_A0_IBUF_2),
    .I1(Sw3_A2_IBUF_0),
    .I2(Sw2_A1_IBUF_1),
    .O(LED13_Y3_OBUF_4)
  );
  LUT3 #(
    .INIT ( 8'h20 ))
  LED11_Y51 (
    .I0(Sw3_A2_IBUF_0),
    .I1(Sw2_A1_IBUF_1),
    .I2(Sw1_A0_IBUF_2),
    .O(LED11_Y5_OBUF_5)
  );
  LUT3 #(
    .INIT ( 8'h80 ))
  LED9_Y71 (
    .I0(Sw1_A0_IBUF_2),
    .I1(Sw3_A2_IBUF_0),
    .I2(Sw2_A1_IBUF_1),
    .O(LED9_Y7_OBUF_6)
  );
  LUT3 #(
    .INIT ( 8'h02 ))
  LED12_Y41 (
    .I0(Sw3_A2_IBUF_0),
    .I1(Sw1_A0_IBUF_2),
    .I2(Sw2_A1_IBUF_1),
    .O(LED12_Y4_OBUF_7)
  );
  LUT3 #(
    .INIT ( 8'h20 ))
  LED10_Y61 (
    .I0(Sw3_A2_IBUF_0),
    .I1(Sw1_A0_IBUF_2),
    .I2(Sw2_A1_IBUF_1),
    .O(LED10_Y6_OBUF_8)
  );
  LUT3 #(
    .INIT ( 8'h02 ))
  LED1_Y21 (
    .I0(Sw2_A1_IBUF_1),
    .I1(Sw1_A0_IBUF_2),
    .I2(Sw3_A2_IBUF_0),
    .O(LED1_Y2_OBUF_9)
  );
  LUT3 #(
    .INIT ( 8'h01 ))
  LED3_Y01 (
    .I0(Sw1_A0_IBUF_2),
    .I1(Sw3_A2_IBUF_0),
    .I2(Sw2_A1_IBUF_1),
    .O(LED3_Y0_OBUF_10)
  );
  IBUF   Sw3_A2_IBUF (
    .I(Sw3_A2),
    .O(Sw3_A2_IBUF_0)
  );
  IBUF   Sw2_A1_IBUF (
    .I(Sw2_A1),
    .O(Sw2_A1_IBUF_1)
  );
  IBUF   Sw1_A0_IBUF (
    .I(Sw1_A0),
    .O(Sw1_A0_IBUF_2)
  );
  OBUF   LED3_Y0_OBUF (
    .I(LED3_Y0_OBUF_10),
    .O(LED3_Y0)
  );
  OBUF   LED2_Y1_OBUF (
    .I(LED2_Y1_OBUF_3),
    .O(LED2_Y1)
  );
  OBUF   LED1_Y2_OBUF (
    .I(LED1_Y2_OBUF_9),
    .O(LED1_Y2)
  );
  OBUF   LED13_Y3_OBUF (
    .I(LED13_Y3_OBUF_4),
    .O(LED13_Y3)
  );
  OBUF   LED12_Y4_OBUF (
    .I(LED12_Y4_OBUF_7),
    .O(LED12_Y4)
  );
  OBUF   LED11_Y5_OBUF (
    .I(LED11_Y5_OBUF_5),
    .O(LED11_Y5)
  );
  OBUF   LED10_Y6_OBUF (
    .I(LED10_Y6_OBUF_8),
    .O(LED10_Y6)
  );
  OBUF   LED9_Y7_OBUF (
    .I(LED9_Y7_OBUF_6),
    .O(LED9_Y7)
  );
endmodule


`ifndef GLBL
`define GLBL

`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;

    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (weak1, weak0) GSR = GSR_int;
    assign (weak1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule

`endif

