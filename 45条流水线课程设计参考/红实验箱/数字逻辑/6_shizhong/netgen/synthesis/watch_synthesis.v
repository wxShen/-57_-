////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2012 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor: Xilinx
// \   \   \/     Version: P.40xd
//  \   \         Application: netgen
//  /   /         Filename: watch_synthesis.v
// /___/   /\     Timestamp: Mon Jan 11 19:38:41 2016
// \   \  /  \ 
//  \___\/\___\
//             
// Command	: -intstyle ise -insert_glbl true -w -dir netgen/synthesis -ofmt verilog -sim watch.ngc watch_synthesis.v 
// Device	: xc6slx150-3-fgg484
// Input file	: watch.ngc
// Output file	: D:\Users\shizhong\netgen\synthesis\watch_synthesis.v
// # of Modules	: 1
// Design Name	: watch
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

module watch (
  clk, reset, set, key_row2, key_row3, key_row4, key_col1, key_col2, num0_scan_select, num1_scan_select, num0_seg7, num1_seg7
);
  input clk;
  input reset;
  input set;
  input key_row2;
  input key_row3;
  input key_row4;
  output key_col1;
  output key_col2;
  output [3 : 0] num0_scan_select;
  output [1 : 0] num1_scan_select;
  output [6 : 0] num0_seg7;
  output [6 : 0] num1_seg7;
  wire clk_BUFGP_0;
  wire reset_IBUF_1;
  wire set_IBUF_2;
  wire key_row2_IBUF_3;
  wire key_row3_IBUF_4;
  wire key_row4_IBUF_5;
  wire num0_scan_select_3_6;
  wire num0_scan_select_2_7;
  wire num0_scan_select_1_8;
  wire num0_scan_select_0_9;
  wire num1_scan_select_1_14;
  wire num1_scan_select_0_15;
  wire num0_seg7_6_20;
  wire num0_seg7_5_21;
  wire num0_seg7_4_22;
  wire num0_seg7_3_23;
  wire num0_seg7_2_24;
  wire num0_seg7_1_25;
  wire num0_seg7_0_26;
  wire num1_seg7_6_27;
  wire num1_seg7_5_28;
  wire num1_seg7_4_29;
  wire num1_seg7_3_30;
  wire num1_seg7_2_31;
  wire num1_seg7_1_32;
  wire num1_seg7_0_33;
  wire state_FSM_FFd3_59;
  wire key_col1_OBUF_60;
  wire sec_l_addEn;
  wire sec_h_addEn;
  wire min_l_addEn;
  wire min_h_addEn;
  wire hour_l_addEn;
  wire hour_h_addEn;
  wire \sec_l[3]_GND_1_o_mux_88_OUT<3> ;
  wire \sec_l[3]_GND_1_o_mux_88_OUT<2> ;
  wire \sec_l[3]_GND_1_o_mux_88_OUT<1> ;
  wire \sec_l[3]_GND_1_o_mux_88_OUT<0> ;
  wire \count[11]_min_l[3]_wide_mux_78_OUT<3> ;
  wire \count[11]_min_l[3]_wide_mux_78_OUT<2> ;
  wire \count[11]_min_l[3]_wide_mux_78_OUT<1> ;
  wire \count[11]_min_l[3]_wide_mux_78_OUT<0> ;
  wire \count[11]_INV_21_o ;
  wire N0;
  wire N1;
  wire reset_inv;
  wire \state_FSM_FFd3-In1 ;
  wire \state_FSM_FFd2-In ;
  wire state_FSM_FFd2_101;
  wire state_FSM_FFd1_102;
  wire \Mram_num0_scan_data[3]_GND_1_o_wide_mux_81_OUT ;
  wire \Mram_num0_scan_data[3]_GND_1_o_wide_mux_81_OUT1 ;
  wire \Mram_num0_scan_data[3]_GND_1_o_wide_mux_81_OUT2 ;
  wire \Mram_num0_scan_data[3]_GND_1_o_wide_mux_81_OUT3 ;
  wire \Mram_num0_scan_data[3]_GND_1_o_wide_mux_81_OUT4 ;
  wire \Mram_num0_scan_data[3]_GND_1_o_wide_mux_81_OUT5 ;
  wire \Mram_num0_scan_data[3]_GND_1_o_wide_mux_81_OUT6 ;
  wire \count[24]_PWR_1_o_LessThan_2_o_inv_inv ;
  wire Mcount_count;
  wire Mcount_count1;
  wire Mcount_count2;
  wire Mcount_count3;
  wire Mcount_count4;
  wire Mcount_count5;
  wire Mcount_count6;
  wire Mcount_count7;
  wire Mcount_count8;
  wire Mcount_count9;
  wire Mcount_count10;
  wire Mcount_count11;
  wire Mcount_count12;
  wire Mcount_count13;
  wire Mcount_count14;
  wire Mcount_count15;
  wire Mcount_count16;
  wire Mcount_count17;
  wire Mcount_count18;
  wire Mcount_count19;
  wire Mcount_count20;
  wire Mcount_count21;
  wire Mcount_count22;
  wire Mcount_count23;
  wire Mcount_count24;
  wire \Mram_num1_scan_data[3]_GND_1_o_wide_mux_91_OUT ;
  wire \Mram_num1_scan_data[3]_GND_1_o_wide_mux_91_OUT1 ;
  wire \Mram_num1_scan_data[3]_GND_1_o_wide_mux_91_OUT2 ;
  wire \Mram_num1_scan_data[3]_GND_1_o_wide_mux_91_OUT3 ;
  wire \Mram_num1_scan_data[3]_GND_1_o_wide_mux_91_OUT4 ;
  wire \Mram_num1_scan_data[3]_GND_1_o_wide_mux_91_OUT5 ;
  wire \Mram_num1_scan_data[3]_GND_1_o_wide_mux_91_OUT6 ;
  wire \Mram_count[11]_PWR_1_o_wide_mux_75_OUT ;
  wire \Mram_count[11]_PWR_1_o_wide_mux_75_OUT1 ;
  wire \Mram_count[11]_PWR_1_o_wide_mux_75_OUT2 ;
  wire \Mram_count[11]_PWR_1_o_wide_mux_75_OUT3 ;
  wire Mcount_min_l;
  wire Mcount_min_l1;
  wire Mcount_min_l2;
  wire Mcount_min_l3;
  wire Mcount_sec_l;
  wire Mcount_sec_l1;
  wire Mcount_sec_l2;
  wire Mcount_sec_l3;
  wire Mcount_sec_h;
  wire Mcount_sec_h1;
  wire Mcount_sec_h2;
  wire Mcount_hour_l2;
  wire \state_FSM_FFd1-In1_0 ;
  wire \Mcompar_count[24]_PWR_1_o_LessThan_2_o_lut<0>_209 ;
  wire \Mcompar_count[24]_PWR_1_o_LessThan_2_o_cy<0>_210 ;
  wire \Mcompar_count[24]_PWR_1_o_LessThan_2_o_lutdi_211 ;
  wire \Mcompar_count[24]_PWR_1_o_LessThan_2_o_lut<1>_212 ;
  wire \Mcompar_count[24]_PWR_1_o_LessThan_2_o_cy<1>_213 ;
  wire \Mcompar_count[24]_PWR_1_o_LessThan_2_o_lutdi1_214 ;
  wire \Mcompar_count[24]_PWR_1_o_LessThan_2_o_lut<2>_215 ;
  wire \Mcompar_count[24]_PWR_1_o_LessThan_2_o_cy<2>_216 ;
  wire \Mcompar_count[24]_PWR_1_o_LessThan_2_o_lut<3>_217 ;
  wire \Mcompar_count[24]_PWR_1_o_LessThan_2_o_cy<3>_218 ;
  wire \Mcompar_count[24]_PWR_1_o_LessThan_2_o_lut<4>_219 ;
  wire \Mcompar_count[24]_PWR_1_o_LessThan_2_o_cy<4>_220 ;
  wire Mmux_sec_h_addEn11;
  wire Mmux_sec_h_addEn12_222;
  wire Mmux_sec_h_addEn111_223;
  wire Mmux_sec_h_addEn112_224;
  wire Mmux_sec_h_addEn113_225;
  wire Mmux_sec_h_addEn114_226;
  wire Mmux_hour_h_addEn1;
  wire Mmux_hour_h_addEn11_228;
  wire N01;
  wire N2;
  wire N4;
  wire hour_l_0_rstpot_260;
  wire hour_l_1_rstpot_261;
  wire hour_l_3_rstpot_262;
  wire hour_h_0_rstpot_263;
  wire hour_h_1_rstpot_264;
  wire min_h_0_rstpot_265;
  wire min_h_1_rstpot_266;
  wire min_h_2_rstpot_267;
  wire N6;
  wire N8;
  wire N9;
  wire N11;
  wire hour_l_2_rstpot_272;
  wire N13;
  wire N14;
  wire N15;
  wire N16;
  wire [3 : 0] num0_scan_data;
  wire [3 : 0] num1_scan_data;
  wire [24 : 0] count;
  wire [3 : 0] sec_l;
  wire [2 : 0] sec_h;
  wire [3 : 0] min_l;
  wire [2 : 0] min_h;
  wire [3 : 0] hour_l;
  wire [1 : 0] hour_h;
  wire [24 : 0] Mcount_count_lut;
  wire [23 : 0] Mcount_count_cy;
  VCC   XST_VCC (
    .P(N0)
  );
  GND   XST_GND (
    .G(N1)
  );
  FD   num1_scan_select_0 (
    .C(clk_BUFGP_0),
    .D(\count[11]_INV_21_o ),
    .Q(num1_scan_select_0_15)
  );
  FD   num1_scan_select_1 (
    .C(clk_BUFGP_0),
    .D(count[11]),
    .Q(num1_scan_select_1_14)
  );
  FD   num0_scan_select_0 (
    .C(clk_BUFGP_0),
    .D(\Mram_count[11]_PWR_1_o_wide_mux_75_OUT ),
    .Q(num0_scan_select_0_9)
  );
  FD   num0_scan_select_1 (
    .C(clk_BUFGP_0),
    .D(\Mram_count[11]_PWR_1_o_wide_mux_75_OUT1 ),
    .Q(num0_scan_select_1_8)
  );
  FD   num0_scan_select_2 (
    .C(clk_BUFGP_0),
    .D(\Mram_count[11]_PWR_1_o_wide_mux_75_OUT2 ),
    .Q(num0_scan_select_2_7)
  );
  FD   num0_scan_select_3 (
    .C(clk_BUFGP_0),
    .D(\Mram_count[11]_PWR_1_o_wide_mux_75_OUT3 ),
    .Q(num0_scan_select_3_6)
  );
  FD   num0_scan_data_0 (
    .C(clk_BUFGP_0),
    .D(\count[11]_min_l[3]_wide_mux_78_OUT<0> ),
    .Q(num0_scan_data[0])
  );
  FD   num0_scan_data_1 (
    .C(clk_BUFGP_0),
    .D(\count[11]_min_l[3]_wide_mux_78_OUT<1> ),
    .Q(num0_scan_data[1])
  );
  FD   num0_scan_data_2 (
    .C(clk_BUFGP_0),
    .D(\count[11]_min_l[3]_wide_mux_78_OUT<2> ),
    .Q(num0_scan_data[2])
  );
  FD   num0_scan_data_3 (
    .C(clk_BUFGP_0),
    .D(\count[11]_min_l[3]_wide_mux_78_OUT<3> ),
    .Q(num0_scan_data[3])
  );
  FD   num1_scan_data_0 (
    .C(clk_BUFGP_0),
    .D(\sec_l[3]_GND_1_o_mux_88_OUT<0> ),
    .Q(num1_scan_data[0])
  );
  FD   num1_scan_data_1 (
    .C(clk_BUFGP_0),
    .D(\sec_l[3]_GND_1_o_mux_88_OUT<1> ),
    .Q(num1_scan_data[1])
  );
  FD   num1_scan_data_2 (
    .C(clk_BUFGP_0),
    .D(\sec_l[3]_GND_1_o_mux_88_OUT<2> ),
    .Q(num1_scan_data[2])
  );
  FD   num1_scan_data_3 (
    .C(clk_BUFGP_0),
    .D(\sec_l[3]_GND_1_o_mux_88_OUT<3> ),
    .Q(num1_scan_data[3])
  );
  FDR   num0_seg7_0 (
    .C(clk_BUFGP_0),
    .D(\Mram_num0_scan_data[3]_GND_1_o_wide_mux_81_OUT ),
    .R(reset_inv),
    .Q(num0_seg7_0_26)
  );
  FDR   num0_seg7_1 (
    .C(clk_BUFGP_0),
    .D(\Mram_num0_scan_data[3]_GND_1_o_wide_mux_81_OUT1 ),
    .R(reset_inv),
    .Q(num0_seg7_1_25)
  );
  FDR   num0_seg7_2 (
    .C(clk_BUFGP_0),
    .D(\Mram_num0_scan_data[3]_GND_1_o_wide_mux_81_OUT2 ),
    .R(reset_inv),
    .Q(num0_seg7_2_24)
  );
  FDR   num0_seg7_3 (
    .C(clk_BUFGP_0),
    .D(\Mram_num0_scan_data[3]_GND_1_o_wide_mux_81_OUT3 ),
    .R(reset_inv),
    .Q(num0_seg7_3_23)
  );
  FDR   num0_seg7_4 (
    .C(clk_BUFGP_0),
    .D(\Mram_num0_scan_data[3]_GND_1_o_wide_mux_81_OUT4 ),
    .R(reset_inv),
    .Q(num0_seg7_4_22)
  );
  FDR   num0_seg7_5 (
    .C(clk_BUFGP_0),
    .D(\Mram_num0_scan_data[3]_GND_1_o_wide_mux_81_OUT5 ),
    .R(reset_inv),
    .Q(num0_seg7_5_21)
  );
  FDR   num0_seg7_6 (
    .C(clk_BUFGP_0),
    .D(\Mram_num0_scan_data[3]_GND_1_o_wide_mux_81_OUT6 ),
    .R(reset_inv),
    .Q(num0_seg7_6_20)
  );
  FDR   num1_seg7_0 (
    .C(clk_BUFGP_0),
    .D(\Mram_num1_scan_data[3]_GND_1_o_wide_mux_91_OUT ),
    .R(reset_inv),
    .Q(num1_seg7_0_33)
  );
  FDR   num1_seg7_1 (
    .C(clk_BUFGP_0),
    .D(\Mram_num1_scan_data[3]_GND_1_o_wide_mux_91_OUT1 ),
    .R(reset_inv),
    .Q(num1_seg7_1_32)
  );
  FDR   num1_seg7_2 (
    .C(clk_BUFGP_0),
    .D(\Mram_num1_scan_data[3]_GND_1_o_wide_mux_91_OUT2 ),
    .R(reset_inv),
    .Q(num1_seg7_2_31)
  );
  FDR   num1_seg7_3 (
    .C(clk_BUFGP_0),
    .D(\Mram_num1_scan_data[3]_GND_1_o_wide_mux_91_OUT3 ),
    .R(reset_inv),
    .Q(num1_seg7_3_30)
  );
  FDR   num1_seg7_4 (
    .C(clk_BUFGP_0),
    .D(\Mram_num1_scan_data[3]_GND_1_o_wide_mux_91_OUT4 ),
    .R(reset_inv),
    .Q(num1_seg7_4_29)
  );
  FDR   num1_seg7_5 (
    .C(clk_BUFGP_0),
    .D(\Mram_num1_scan_data[3]_GND_1_o_wide_mux_91_OUT5 ),
    .R(reset_inv),
    .Q(num1_seg7_5_28)
  );
  FDR   num1_seg7_6 (
    .C(clk_BUFGP_0),
    .D(\Mram_num1_scan_data[3]_GND_1_o_wide_mux_91_OUT6 ),
    .R(reset_inv),
    .Q(num1_seg7_6_27)
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  \Mcount_count_lut<0>  (
    .I0(N1),
    .I1(count[0]),
    .I2(\Mcompar_count[24]_PWR_1_o_LessThan_2_o_cy<4>_220 ),
    .O(Mcount_count_lut[0])
  );
  MUXCY   \Mcount_count_cy<0>  (
    .CI(\count[24]_PWR_1_o_LessThan_2_o_inv_inv ),
    .DI(N1),
    .S(Mcount_count_lut[0]),
    .O(Mcount_count_cy[0])
  );
  XORCY   \Mcount_count_xor<0>  (
    .CI(\count[24]_PWR_1_o_LessThan_2_o_inv_inv ),
    .LI(Mcount_count_lut[0]),
    .O(Mcount_count)
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  \Mcount_count_lut<1>  (
    .I0(N1),
    .I1(count[1]),
    .I2(\Mcompar_count[24]_PWR_1_o_LessThan_2_o_cy<4>_220 ),
    .O(Mcount_count_lut[1])
  );
  MUXCY   \Mcount_count_cy<1>  (
    .CI(Mcount_count_cy[0]),
    .DI(N1),
    .S(Mcount_count_lut[1]),
    .O(Mcount_count_cy[1])
  );
  XORCY   \Mcount_count_xor<1>  (
    .CI(Mcount_count_cy[0]),
    .LI(Mcount_count_lut[1]),
    .O(Mcount_count1)
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  \Mcount_count_lut<2>  (
    .I0(N1),
    .I1(count[2]),
    .I2(\Mcompar_count[24]_PWR_1_o_LessThan_2_o_cy<4>_220 ),
    .O(Mcount_count_lut[2])
  );
  MUXCY   \Mcount_count_cy<2>  (
    .CI(Mcount_count_cy[1]),
    .DI(N1),
    .S(Mcount_count_lut[2]),
    .O(Mcount_count_cy[2])
  );
  XORCY   \Mcount_count_xor<2>  (
    .CI(Mcount_count_cy[1]),
    .LI(Mcount_count_lut[2]),
    .O(Mcount_count2)
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  \Mcount_count_lut<3>  (
    .I0(N1),
    .I1(count[3]),
    .I2(\Mcompar_count[24]_PWR_1_o_LessThan_2_o_cy<4>_220 ),
    .O(Mcount_count_lut[3])
  );
  MUXCY   \Mcount_count_cy<3>  (
    .CI(Mcount_count_cy[2]),
    .DI(N1),
    .S(Mcount_count_lut[3]),
    .O(Mcount_count_cy[3])
  );
  XORCY   \Mcount_count_xor<3>  (
    .CI(Mcount_count_cy[2]),
    .LI(Mcount_count_lut[3]),
    .O(Mcount_count3)
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  \Mcount_count_lut<4>  (
    .I0(N1),
    .I1(count[4]),
    .I2(\Mcompar_count[24]_PWR_1_o_LessThan_2_o_cy<4>_220 ),
    .O(Mcount_count_lut[4])
  );
  MUXCY   \Mcount_count_cy<4>  (
    .CI(Mcount_count_cy[3]),
    .DI(N1),
    .S(Mcount_count_lut[4]),
    .O(Mcount_count_cy[4])
  );
  XORCY   \Mcount_count_xor<4>  (
    .CI(Mcount_count_cy[3]),
    .LI(Mcount_count_lut[4]),
    .O(Mcount_count4)
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  \Mcount_count_lut<5>  (
    .I0(N1),
    .I1(count[5]),
    .I2(\Mcompar_count[24]_PWR_1_o_LessThan_2_o_cy<4>_220 ),
    .O(Mcount_count_lut[5])
  );
  MUXCY   \Mcount_count_cy<5>  (
    .CI(Mcount_count_cy[4]),
    .DI(N1),
    .S(Mcount_count_lut[5]),
    .O(Mcount_count_cy[5])
  );
  XORCY   \Mcount_count_xor<5>  (
    .CI(Mcount_count_cy[4]),
    .LI(Mcount_count_lut[5]),
    .O(Mcount_count5)
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  \Mcount_count_lut<6>  (
    .I0(N1),
    .I1(count[6]),
    .I2(\Mcompar_count[24]_PWR_1_o_LessThan_2_o_cy<4>_220 ),
    .O(Mcount_count_lut[6])
  );
  MUXCY   \Mcount_count_cy<6>  (
    .CI(Mcount_count_cy[5]),
    .DI(N1),
    .S(Mcount_count_lut[6]),
    .O(Mcount_count_cy[6])
  );
  XORCY   \Mcount_count_xor<6>  (
    .CI(Mcount_count_cy[5]),
    .LI(Mcount_count_lut[6]),
    .O(Mcount_count6)
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  \Mcount_count_lut<7>  (
    .I0(N1),
    .I1(count[7]),
    .I2(\Mcompar_count[24]_PWR_1_o_LessThan_2_o_cy<4>_220 ),
    .O(Mcount_count_lut[7])
  );
  MUXCY   \Mcount_count_cy<7>  (
    .CI(Mcount_count_cy[6]),
    .DI(N1),
    .S(Mcount_count_lut[7]),
    .O(Mcount_count_cy[7])
  );
  XORCY   \Mcount_count_xor<7>  (
    .CI(Mcount_count_cy[6]),
    .LI(Mcount_count_lut[7]),
    .O(Mcount_count7)
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  \Mcount_count_lut<8>  (
    .I0(N1),
    .I1(count[8]),
    .I2(\Mcompar_count[24]_PWR_1_o_LessThan_2_o_cy<4>_220 ),
    .O(Mcount_count_lut[8])
  );
  MUXCY   \Mcount_count_cy<8>  (
    .CI(Mcount_count_cy[7]),
    .DI(N1),
    .S(Mcount_count_lut[8]),
    .O(Mcount_count_cy[8])
  );
  XORCY   \Mcount_count_xor<8>  (
    .CI(Mcount_count_cy[7]),
    .LI(Mcount_count_lut[8]),
    .O(Mcount_count8)
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  \Mcount_count_lut<9>  (
    .I0(N1),
    .I1(count[9]),
    .I2(\Mcompar_count[24]_PWR_1_o_LessThan_2_o_cy<4>_220 ),
    .O(Mcount_count_lut[9])
  );
  MUXCY   \Mcount_count_cy<9>  (
    .CI(Mcount_count_cy[8]),
    .DI(N1),
    .S(Mcount_count_lut[9]),
    .O(Mcount_count_cy[9])
  );
  XORCY   \Mcount_count_xor<9>  (
    .CI(Mcount_count_cy[8]),
    .LI(Mcount_count_lut[9]),
    .O(Mcount_count9)
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  \Mcount_count_lut<10>  (
    .I0(N1),
    .I1(count[10]),
    .I2(\Mcompar_count[24]_PWR_1_o_LessThan_2_o_cy<4>_220 ),
    .O(Mcount_count_lut[10])
  );
  MUXCY   \Mcount_count_cy<10>  (
    .CI(Mcount_count_cy[9]),
    .DI(N1),
    .S(Mcount_count_lut[10]),
    .O(Mcount_count_cy[10])
  );
  XORCY   \Mcount_count_xor<10>  (
    .CI(Mcount_count_cy[9]),
    .LI(Mcount_count_lut[10]),
    .O(Mcount_count10)
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  \Mcount_count_lut<11>  (
    .I0(N1),
    .I1(count[11]),
    .I2(\Mcompar_count[24]_PWR_1_o_LessThan_2_o_cy<4>_220 ),
    .O(Mcount_count_lut[11])
  );
  MUXCY   \Mcount_count_cy<11>  (
    .CI(Mcount_count_cy[10]),
    .DI(N1),
    .S(Mcount_count_lut[11]),
    .O(Mcount_count_cy[11])
  );
  XORCY   \Mcount_count_xor<11>  (
    .CI(Mcount_count_cy[10]),
    .LI(Mcount_count_lut[11]),
    .O(Mcount_count11)
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  \Mcount_count_lut<12>  (
    .I0(N1),
    .I1(count[12]),
    .I2(\Mcompar_count[24]_PWR_1_o_LessThan_2_o_cy<4>_220 ),
    .O(Mcount_count_lut[12])
  );
  MUXCY   \Mcount_count_cy<12>  (
    .CI(Mcount_count_cy[11]),
    .DI(N1),
    .S(Mcount_count_lut[12]),
    .O(Mcount_count_cy[12])
  );
  XORCY   \Mcount_count_xor<12>  (
    .CI(Mcount_count_cy[11]),
    .LI(Mcount_count_lut[12]),
    .O(Mcount_count12)
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  \Mcount_count_lut<13>  (
    .I0(N1),
    .I1(count[13]),
    .I2(\Mcompar_count[24]_PWR_1_o_LessThan_2_o_cy<4>_220 ),
    .O(Mcount_count_lut[13])
  );
  MUXCY   \Mcount_count_cy<13>  (
    .CI(Mcount_count_cy[12]),
    .DI(N1),
    .S(Mcount_count_lut[13]),
    .O(Mcount_count_cy[13])
  );
  XORCY   \Mcount_count_xor<13>  (
    .CI(Mcount_count_cy[12]),
    .LI(Mcount_count_lut[13]),
    .O(Mcount_count13)
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  \Mcount_count_lut<14>  (
    .I0(N1),
    .I1(count[14]),
    .I2(\Mcompar_count[24]_PWR_1_o_LessThan_2_o_cy<4>_220 ),
    .O(Mcount_count_lut[14])
  );
  MUXCY   \Mcount_count_cy<14>  (
    .CI(Mcount_count_cy[13]),
    .DI(N1),
    .S(Mcount_count_lut[14]),
    .O(Mcount_count_cy[14])
  );
  XORCY   \Mcount_count_xor<14>  (
    .CI(Mcount_count_cy[13]),
    .LI(Mcount_count_lut[14]),
    .O(Mcount_count14)
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  \Mcount_count_lut<15>  (
    .I0(N1),
    .I1(count[15]),
    .I2(\Mcompar_count[24]_PWR_1_o_LessThan_2_o_cy<4>_220 ),
    .O(Mcount_count_lut[15])
  );
  MUXCY   \Mcount_count_cy<15>  (
    .CI(Mcount_count_cy[14]),
    .DI(N1),
    .S(Mcount_count_lut[15]),
    .O(Mcount_count_cy[15])
  );
  XORCY   \Mcount_count_xor<15>  (
    .CI(Mcount_count_cy[14]),
    .LI(Mcount_count_lut[15]),
    .O(Mcount_count15)
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  \Mcount_count_lut<16>  (
    .I0(N1),
    .I1(count[16]),
    .I2(\Mcompar_count[24]_PWR_1_o_LessThan_2_o_cy<4>_220 ),
    .O(Mcount_count_lut[16])
  );
  MUXCY   \Mcount_count_cy<16>  (
    .CI(Mcount_count_cy[15]),
    .DI(N1),
    .S(Mcount_count_lut[16]),
    .O(Mcount_count_cy[16])
  );
  XORCY   \Mcount_count_xor<16>  (
    .CI(Mcount_count_cy[15]),
    .LI(Mcount_count_lut[16]),
    .O(Mcount_count16)
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  \Mcount_count_lut<17>  (
    .I0(N1),
    .I1(count[17]),
    .I2(\Mcompar_count[24]_PWR_1_o_LessThan_2_o_cy<4>_220 ),
    .O(Mcount_count_lut[17])
  );
  MUXCY   \Mcount_count_cy<17>  (
    .CI(Mcount_count_cy[16]),
    .DI(N1),
    .S(Mcount_count_lut[17]),
    .O(Mcount_count_cy[17])
  );
  XORCY   \Mcount_count_xor<17>  (
    .CI(Mcount_count_cy[16]),
    .LI(Mcount_count_lut[17]),
    .O(Mcount_count17)
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  \Mcount_count_lut<18>  (
    .I0(N1),
    .I1(count[18]),
    .I2(\Mcompar_count[24]_PWR_1_o_LessThan_2_o_cy<4>_220 ),
    .O(Mcount_count_lut[18])
  );
  MUXCY   \Mcount_count_cy<18>  (
    .CI(Mcount_count_cy[17]),
    .DI(N1),
    .S(Mcount_count_lut[18]),
    .O(Mcount_count_cy[18])
  );
  XORCY   \Mcount_count_xor<18>  (
    .CI(Mcount_count_cy[17]),
    .LI(Mcount_count_lut[18]),
    .O(Mcount_count18)
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  \Mcount_count_lut<19>  (
    .I0(N1),
    .I1(count[19]),
    .I2(\Mcompar_count[24]_PWR_1_o_LessThan_2_o_cy<4>_220 ),
    .O(Mcount_count_lut[19])
  );
  MUXCY   \Mcount_count_cy<19>  (
    .CI(Mcount_count_cy[18]),
    .DI(N1),
    .S(Mcount_count_lut[19]),
    .O(Mcount_count_cy[19])
  );
  XORCY   \Mcount_count_xor<19>  (
    .CI(Mcount_count_cy[18]),
    .LI(Mcount_count_lut[19]),
    .O(Mcount_count19)
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  \Mcount_count_lut<20>  (
    .I0(N1),
    .I1(count[20]),
    .I2(\Mcompar_count[24]_PWR_1_o_LessThan_2_o_cy<4>_220 ),
    .O(Mcount_count_lut[20])
  );
  MUXCY   \Mcount_count_cy<20>  (
    .CI(Mcount_count_cy[19]),
    .DI(N1),
    .S(Mcount_count_lut[20]),
    .O(Mcount_count_cy[20])
  );
  XORCY   \Mcount_count_xor<20>  (
    .CI(Mcount_count_cy[19]),
    .LI(Mcount_count_lut[20]),
    .O(Mcount_count20)
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  \Mcount_count_lut<21>  (
    .I0(N1),
    .I1(count[21]),
    .I2(\Mcompar_count[24]_PWR_1_o_LessThan_2_o_cy<4>_220 ),
    .O(Mcount_count_lut[21])
  );
  MUXCY   \Mcount_count_cy<21>  (
    .CI(Mcount_count_cy[20]),
    .DI(N1),
    .S(Mcount_count_lut[21]),
    .O(Mcount_count_cy[21])
  );
  XORCY   \Mcount_count_xor<21>  (
    .CI(Mcount_count_cy[20]),
    .LI(Mcount_count_lut[21]),
    .O(Mcount_count21)
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  \Mcount_count_lut<22>  (
    .I0(N1),
    .I1(count[22]),
    .I2(\Mcompar_count[24]_PWR_1_o_LessThan_2_o_cy<4>_220 ),
    .O(Mcount_count_lut[22])
  );
  MUXCY   \Mcount_count_cy<22>  (
    .CI(Mcount_count_cy[21]),
    .DI(N1),
    .S(Mcount_count_lut[22]),
    .O(Mcount_count_cy[22])
  );
  XORCY   \Mcount_count_xor<22>  (
    .CI(Mcount_count_cy[21]),
    .LI(Mcount_count_lut[22]),
    .O(Mcount_count22)
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  \Mcount_count_lut<23>  (
    .I0(N1),
    .I1(count[23]),
    .I2(\Mcompar_count[24]_PWR_1_o_LessThan_2_o_cy<4>_220 ),
    .O(Mcount_count_lut[23])
  );
  MUXCY   \Mcount_count_cy<23>  (
    .CI(Mcount_count_cy[22]),
    .DI(N1),
    .S(Mcount_count_lut[23]),
    .O(Mcount_count_cy[23])
  );
  XORCY   \Mcount_count_xor<23>  (
    .CI(Mcount_count_cy[22]),
    .LI(Mcount_count_lut[23]),
    .O(Mcount_count23)
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  \Mcount_count_lut<24>  (
    .I0(N1),
    .I1(count[24]),
    .I2(\Mcompar_count[24]_PWR_1_o_LessThan_2_o_cy<4>_220 ),
    .O(Mcount_count_lut[24])
  );
  XORCY   \Mcount_count_xor<24>  (
    .CI(Mcount_count_cy[23]),
    .LI(Mcount_count_lut[24]),
    .O(Mcount_count24)
  );
  FDR   state_FSM_FFd3 (
    .C(clk_BUFGP_0),
    .D(\state_FSM_FFd3-In1 ),
    .R(\state_FSM_FFd1-In1_0 ),
    .Q(state_FSM_FFd3_59)
  );
  FDR   count_0 (
    .C(clk_BUFGP_0),
    .D(Mcount_count),
    .R(reset_inv),
    .Q(count[0])
  );
  FDR   count_1 (
    .C(clk_BUFGP_0),
    .D(Mcount_count1),
    .R(reset_inv),
    .Q(count[1])
  );
  FDR   count_2 (
    .C(clk_BUFGP_0),
    .D(Mcount_count2),
    .R(reset_inv),
    .Q(count[2])
  );
  FDR   count_3 (
    .C(clk_BUFGP_0),
    .D(Mcount_count3),
    .R(reset_inv),
    .Q(count[3])
  );
  FDR   count_4 (
    .C(clk_BUFGP_0),
    .D(Mcount_count4),
    .R(reset_inv),
    .Q(count[4])
  );
  FDR   count_5 (
    .C(clk_BUFGP_0),
    .D(Mcount_count5),
    .R(reset_inv),
    .Q(count[5])
  );
  FDR   count_6 (
    .C(clk_BUFGP_0),
    .D(Mcount_count6),
    .R(reset_inv),
    .Q(count[6])
  );
  FDR   count_7 (
    .C(clk_BUFGP_0),
    .D(Mcount_count7),
    .R(reset_inv),
    .Q(count[7])
  );
  FDR   count_8 (
    .C(clk_BUFGP_0),
    .D(Mcount_count8),
    .R(reset_inv),
    .Q(count[8])
  );
  FDR   count_9 (
    .C(clk_BUFGP_0),
    .D(Mcount_count9),
    .R(reset_inv),
    .Q(count[9])
  );
  FDR   count_10 (
    .C(clk_BUFGP_0),
    .D(Mcount_count10),
    .R(reset_inv),
    .Q(count[10])
  );
  FDR   count_11 (
    .C(clk_BUFGP_0),
    .D(Mcount_count11),
    .R(reset_inv),
    .Q(count[11])
  );
  FDR   count_12 (
    .C(clk_BUFGP_0),
    .D(Mcount_count12),
    .R(reset_inv),
    .Q(count[12])
  );
  FDR   count_13 (
    .C(clk_BUFGP_0),
    .D(Mcount_count13),
    .R(reset_inv),
    .Q(count[13])
  );
  FDR   count_14 (
    .C(clk_BUFGP_0),
    .D(Mcount_count14),
    .R(reset_inv),
    .Q(count[14])
  );
  FDR   count_15 (
    .C(clk_BUFGP_0),
    .D(Mcount_count15),
    .R(reset_inv),
    .Q(count[15])
  );
  FDR   count_16 (
    .C(clk_BUFGP_0),
    .D(Mcount_count16),
    .R(reset_inv),
    .Q(count[16])
  );
  FDR   count_17 (
    .C(clk_BUFGP_0),
    .D(Mcount_count17),
    .R(reset_inv),
    .Q(count[17])
  );
  FDR   count_18 (
    .C(clk_BUFGP_0),
    .D(Mcount_count18),
    .R(reset_inv),
    .Q(count[18])
  );
  FDR   count_19 (
    .C(clk_BUFGP_0),
    .D(Mcount_count19),
    .R(reset_inv),
    .Q(count[19])
  );
  FDR   count_20 (
    .C(clk_BUFGP_0),
    .D(Mcount_count20),
    .R(reset_inv),
    .Q(count[20])
  );
  FDR   count_21 (
    .C(clk_BUFGP_0),
    .D(Mcount_count21),
    .R(reset_inv),
    .Q(count[21])
  );
  FDR   count_22 (
    .C(clk_BUFGP_0),
    .D(Mcount_count22),
    .R(reset_inv),
    .Q(count[22])
  );
  FDR   count_23 (
    .C(clk_BUFGP_0),
    .D(Mcount_count23),
    .R(reset_inv),
    .Q(count[23])
  );
  FDR   count_24 (
    .C(clk_BUFGP_0),
    .D(Mcount_count24),
    .R(reset_inv),
    .Q(count[24])
  );
  FDR   state_FSM_FFd2 (
    .C(clk_BUFGP_0),
    .D(\state_FSM_FFd2-In ),
    .R(reset_inv),
    .Q(state_FSM_FFd2_101)
  );
  FDR   state_FSM_FFd1 (
    .C(clk_BUFGP_0),
    .D(key_col1_OBUF_60),
    .R(\state_FSM_FFd1-In1_0 ),
    .Q(state_FSM_FFd1_102)
  );
  FDRE   sec_h_0 (
    .C(clk_BUFGP_0),
    .CE(sec_h_addEn),
    .D(Mcount_sec_h),
    .R(reset_inv),
    .Q(sec_h[0])
  );
  FDRE   sec_h_1 (
    .C(clk_BUFGP_0),
    .CE(sec_h_addEn),
    .D(Mcount_sec_h1),
    .R(reset_inv),
    .Q(sec_h[1])
  );
  FDRE   sec_h_2 (
    .C(clk_BUFGP_0),
    .CE(sec_h_addEn),
    .D(Mcount_sec_h2),
    .R(reset_inv),
    .Q(sec_h[2])
  );
  FDRE   min_l_0 (
    .C(clk_BUFGP_0),
    .CE(min_l_addEn),
    .D(Mcount_min_l),
    .R(reset_inv),
    .Q(min_l[0])
  );
  FDRE   min_l_1 (
    .C(clk_BUFGP_0),
    .CE(min_l_addEn),
    .D(Mcount_min_l1),
    .R(reset_inv),
    .Q(min_l[1])
  );
  FDRE   min_l_2 (
    .C(clk_BUFGP_0),
    .CE(min_l_addEn),
    .D(Mcount_min_l2),
    .R(reset_inv),
    .Q(min_l[2])
  );
  FDRE   min_l_3 (
    .C(clk_BUFGP_0),
    .CE(min_l_addEn),
    .D(Mcount_min_l3),
    .R(reset_inv),
    .Q(min_l[3])
  );
  FDRE   sec_l_0 (
    .C(clk_BUFGP_0),
    .CE(sec_l_addEn),
    .D(Mcount_sec_l),
    .R(reset_inv),
    .Q(sec_l[0])
  );
  FDRE   sec_l_1 (
    .C(clk_BUFGP_0),
    .CE(sec_l_addEn),
    .D(Mcount_sec_l1),
    .R(reset_inv),
    .Q(sec_l[1])
  );
  FDRE   sec_l_2 (
    .C(clk_BUFGP_0),
    .CE(sec_l_addEn),
    .D(Mcount_sec_l2),
    .R(reset_inv),
    .Q(sec_l[2])
  );
  FDRE   sec_l_3 (
    .C(clk_BUFGP_0),
    .CE(sec_l_addEn),
    .D(Mcount_sec_l3),
    .R(reset_inv),
    .Q(sec_l[3])
  );
  LUT5 #(
    .INIT ( 32'h80000000 ))
  \Mcompar_count[24]_PWR_1_o_LessThan_2_o_lut<0>  (
    .I0(count[0]),
    .I1(count[1]),
    .I2(count[2]),
    .I3(count[3]),
    .I4(count[4]),
    .O(\Mcompar_count[24]_PWR_1_o_LessThan_2_o_lut<0>_209 )
  );
  MUXCY   \Mcompar_count[24]_PWR_1_o_LessThan_2_o_cy<0>  (
    .CI(N0),
    .DI(N1),
    .S(\Mcompar_count[24]_PWR_1_o_LessThan_2_o_lut<0>_209 ),
    .O(\Mcompar_count[24]_PWR_1_o_LessThan_2_o_cy<0>_210 )
  );
  LUT4 #(
    .INIT ( 16'hAAA8 ))
  \Mcompar_count[24]_PWR_1_o_LessThan_2_o_lutdi  (
    .I0(count[9]),
    .I1(count[8]),
    .I2(count[7]),
    .I3(count[6]),
    .O(\Mcompar_count[24]_PWR_1_o_LessThan_2_o_lutdi_211 )
  );
  LUT5 #(
    .INIT ( 32'h00000200 ))
  \Mcompar_count[24]_PWR_1_o_LessThan_2_o_lut<1>  (
    .I0(count[9]),
    .I1(count[6]),
    .I2(count[7]),
    .I3(count[5]),
    .I4(count[8]),
    .O(\Mcompar_count[24]_PWR_1_o_LessThan_2_o_lut<1>_212 )
  );
  MUXCY   \Mcompar_count[24]_PWR_1_o_LessThan_2_o_cy<1>  (
    .CI(\Mcompar_count[24]_PWR_1_o_LessThan_2_o_cy<0>_210 ),
    .DI(\Mcompar_count[24]_PWR_1_o_LessThan_2_o_lutdi_211 ),
    .S(\Mcompar_count[24]_PWR_1_o_LessThan_2_o_lut<1>_212 ),
    .O(\Mcompar_count[24]_PWR_1_o_LessThan_2_o_cy<1>_213 )
  );
  LUT5 #(
    .INIT ( 32'hFFFFFEEE ))
  \Mcompar_count[24]_PWR_1_o_LessThan_2_o_lutdi1  (
    .I0(count[12]),
    .I1(count[14]),
    .I2(count[11]),
    .I3(count[10]),
    .I4(count[13]),
    .O(\Mcompar_count[24]_PWR_1_o_LessThan_2_o_lutdi1_214 )
  );
  LUT5 #(
    .INIT ( 32'h00010000 ))
  \Mcompar_count[24]_PWR_1_o_LessThan_2_o_lut<2>  (
    .I0(count[10]),
    .I1(count[12]),
    .I2(count[13]),
    .I3(count[14]),
    .I4(count[11]),
    .O(\Mcompar_count[24]_PWR_1_o_LessThan_2_o_lut<2>_215 )
  );
  MUXCY   \Mcompar_count[24]_PWR_1_o_LessThan_2_o_cy<2>  (
    .CI(\Mcompar_count[24]_PWR_1_o_LessThan_2_o_cy<1>_213 ),
    .DI(\Mcompar_count[24]_PWR_1_o_LessThan_2_o_lutdi1_214 ),
    .S(\Mcompar_count[24]_PWR_1_o_LessThan_2_o_lut<2>_215 ),
    .O(\Mcompar_count[24]_PWR_1_o_LessThan_2_o_cy<2>_216 )
  );
  LUT5 #(
    .INIT ( 32'h40000000 ))
  \Mcompar_count[24]_PWR_1_o_LessThan_2_o_lut<3>  (
    .I0(count[19]),
    .I1(count[16]),
    .I2(count[17]),
    .I3(count[18]),
    .I4(count[15]),
    .O(\Mcompar_count[24]_PWR_1_o_LessThan_2_o_lut<3>_217 )
  );
  MUXCY   \Mcompar_count[24]_PWR_1_o_LessThan_2_o_cy<3>  (
    .CI(\Mcompar_count[24]_PWR_1_o_LessThan_2_o_cy<2>_216 ),
    .DI(count[19]),
    .S(\Mcompar_count[24]_PWR_1_o_LessThan_2_o_lut<3>_217 ),
    .O(\Mcompar_count[24]_PWR_1_o_LessThan_2_o_cy<3>_218 )
  );
  LUT5 #(
    .INIT ( 32'h80000000 ))
  \Mcompar_count[24]_PWR_1_o_LessThan_2_o_lut<4>  (
    .I0(count[24]),
    .I1(count[23]),
    .I2(count[22]),
    .I3(count[21]),
    .I4(count[20]),
    .O(\Mcompar_count[24]_PWR_1_o_LessThan_2_o_lut<4>_219 )
  );
  MUXCY   \Mcompar_count[24]_PWR_1_o_LessThan_2_o_cy<4>  (
    .CI(\Mcompar_count[24]_PWR_1_o_LessThan_2_o_cy<3>_218 ),
    .DI(N1),
    .S(\Mcompar_count[24]_PWR_1_o_LessThan_2_o_lut<4>_219 ),
    .O(\Mcompar_count[24]_PWR_1_o_LessThan_2_o_cy<4>_220 )
  );
  LUT2 #(
    .INIT ( 4'hD ))
  \state_FSM_FFd3-In11  (
    .I0(state_FSM_FFd2_101),
    .I1(state_FSM_FFd3_59),
    .O(\state_FSM_FFd3-In1 )
  );
  LUT3 #(
    .INIT ( 8'hF2 ))
  key_col11 (
    .I0(state_FSM_FFd2_101),
    .I1(state_FSM_FFd3_59),
    .I2(state_FSM_FFd1_102),
    .O(key_col1_OBUF_60)
  );
  LUT2 #(
    .INIT ( 4'h7 ))
  \Mram_count[11]_PWR_1_o_wide_mux_75_OUT12  (
    .I0(count[10]),
    .I1(count[11]),
    .O(\Mram_count[11]_PWR_1_o_wide_mux_75_OUT )
  );
  LUT2 #(
    .INIT ( 4'hD ))
  \Mram_count[11]_PWR_1_o_wide_mux_75_OUT111  (
    .I0(count[11]),
    .I1(count[10]),
    .O(\Mram_count[11]_PWR_1_o_wide_mux_75_OUT1 )
  );
  LUT2 #(
    .INIT ( 4'hD ))
  \Mram_count[11]_PWR_1_o_wide_mux_75_OUT21  (
    .I0(count[10]),
    .I1(count[11]),
    .O(\Mram_count[11]_PWR_1_o_wide_mux_75_OUT2 )
  );
  LUT2 #(
    .INIT ( 4'hE ))
  \Mram_count[11]_PWR_1_o_wide_mux_75_OUT31  (
    .I0(count[11]),
    .I1(count[10]),
    .O(\Mram_count[11]_PWR_1_o_wide_mux_75_OUT3 )
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  \Mmux_sec_l[3]_GND_1_o_mux_88_OUT41  (
    .I0(count[11]),
    .I1(sec_l[3]),
    .O(\sec_l[3]_GND_1_o_mux_88_OUT<3> )
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \Mmux_sec_l[3]_GND_1_o_mux_88_OUT31  (
    .I0(count[11]),
    .I1(sec_h[2]),
    .I2(sec_l[2]),
    .O(\sec_l[3]_GND_1_o_mux_88_OUT<2> )
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \Mmux_sec_l[3]_GND_1_o_mux_88_OUT21  (
    .I0(count[11]),
    .I1(sec_h[1]),
    .I2(sec_l[1]),
    .O(\sec_l[3]_GND_1_o_mux_88_OUT<1> )
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \Mmux_sec_l[3]_GND_1_o_mux_88_OUT11  (
    .I0(count[11]),
    .I1(sec_h[0]),
    .I2(sec_l[0]),
    .O(\sec_l[3]_GND_1_o_mux_88_OUT<0> )
  );
  LUT4 #(
    .INIT ( 16'h80FF ))
  \state_FSM_FFd1-In1_01  (
    .I0(key_row3_IBUF_4),
    .I1(key_row4_IBUF_5),
    .I2(key_row2_IBUF_3),
    .I3(reset_IBUF_1),
    .O(\state_FSM_FFd1-In1_0 )
  );
  LUT3 #(
    .INIT ( 8'h18 ))
  \Mcount_sec_h_xor<2>11  (
    .I0(sec_h[1]),
    .I1(sec_h[0]),
    .I2(sec_h[2]),
    .O(Mcount_sec_h2)
  );
  LUT4 #(
    .INIT ( 16'h1444 ))
  \Mcount_min_l_xor<2>11  (
    .I0(min_l[3]),
    .I1(min_l[2]),
    .I2(min_l[0]),
    .I3(min_l[1]),
    .O(Mcount_min_l2)
  );
  LUT4 #(
    .INIT ( 16'h1444 ))
  \Mcount_sec_l_xor<2>11  (
    .I0(sec_l[3]),
    .I1(sec_l[2]),
    .I2(sec_l[0]),
    .I3(sec_l[1]),
    .O(Mcount_sec_l2)
  );
  LUT4 #(
    .INIT ( 16'hA820 ))
  \Mmux_count[11]_min_l[3]_wide_mux_78_OUT41  (
    .I0(count[10]),
    .I1(count[11]),
    .I2(hour_l[3]),
    .I3(min_l[3]),
    .O(\count[11]_min_l[3]_wide_mux_78_OUT<3> )
  );
  LUT5 #(
    .INIT ( 32'hE6C4A280 ))
  \Mmux_count[11]_min_l[3]_wide_mux_78_OUT31  (
    .I0(count[11]),
    .I1(count[10]),
    .I2(min_l[2]),
    .I3(min_h[2]),
    .I4(hour_l[2]),
    .O(\count[11]_min_l[3]_wide_mux_78_OUT<2> )
  );
  LUT3 #(
    .INIT ( 8'h14 ))
  \Mcount_min_l_xor<1>11  (
    .I0(min_l[3]),
    .I1(min_l[0]),
    .I2(min_l[1]),
    .O(Mcount_min_l1)
  );
  LUT3 #(
    .INIT ( 8'h14 ))
  \Mcount_sec_l_xor<1>11  (
    .I0(sec_l[3]),
    .I1(sec_l[0]),
    .I2(sec_l[1]),
    .O(Mcount_sec_l1)
  );
  LUT3 #(
    .INIT ( 8'h14 ))
  \Mcount_sec_h_xor<1>11  (
    .I0(sec_h[2]),
    .I1(sec_h[0]),
    .I2(sec_h[1]),
    .O(Mcount_sec_h1)
  );
  LUT4 #(
    .INIT ( 16'h0155 ))
  \Mcount_min_l_xor<0>11  (
    .I0(min_l[0]),
    .I1(min_l[2]),
    .I2(min_l[1]),
    .I3(min_l[3]),
    .O(Mcount_min_l)
  );
  LUT4 #(
    .INIT ( 16'h0155 ))
  \Mcount_sec_l_xor<0>11  (
    .I0(sec_l[0]),
    .I1(sec_l[2]),
    .I2(sec_l[1]),
    .I3(sec_l[3]),
    .O(Mcount_sec_l)
  );
  LUT3 #(
    .INIT ( 8'h15 ))
  \Mcount_sec_h_xor<0>11  (
    .I0(sec_h[0]),
    .I1(sec_h[1]),
    .I2(sec_h[2]),
    .O(Mcount_sec_h)
  );
  LUT6 #(
    .INIT ( 64'hFD75B931EC64A820 ))
  \Mmux_count[11]_min_l[3]_wide_mux_78_OUT11  (
    .I0(count[10]),
    .I1(count[11]),
    .I2(hour_l[0]),
    .I3(min_l[0]),
    .I4(min_h[0]),
    .I5(hour_h[0]),
    .O(\count[11]_min_l[3]_wide_mux_78_OUT<0> )
  );
  LUT6 #(
    .INIT ( 64'hFD75B931EC64A820 ))
  \Mmux_count[11]_min_l[3]_wide_mux_78_OUT21  (
    .I0(count[10]),
    .I1(count[11]),
    .I2(hour_l[1]),
    .I3(min_l[1]),
    .I4(min_h[1]),
    .I5(hour_h[1]),
    .O(\count[11]_min_l[3]_wide_mux_78_OUT<1> )
  );
  LUT6 #(
    .INIT ( 64'h7878787878707878 ))
  \Mcount_hour_l_xor<2>11  (
    .I0(hour_l[0]),
    .I1(hour_l[1]),
    .I2(hour_l[2]),
    .I3(hour_l[3]),
    .I4(hour_h[1]),
    .I5(hour_h[0]),
    .O(Mcount_hour_l2)
  );
  LUT6 #(
    .INIT ( 64'h2FFFFFFF2EEEEEEE ))
  \state_FSM_FFd2-In1  (
    .I0(state_FSM_FFd3_59),
    .I1(state_FSM_FFd2_101),
    .I2(key_row2_IBUF_3),
    .I3(key_row3_IBUF_4),
    .I4(key_row4_IBUF_5),
    .I5(state_FSM_FFd1_102),
    .O(\state_FSM_FFd2-In )
  );
  LUT4 #(
    .INIT ( 16'h1647 ))
  \Mram_num0_scan_data[3]_GND_1_o_wide_mux_81_OUT31  (
    .I0(num0_scan_data[3]),
    .I1(num0_scan_data[1]),
    .I2(num0_scan_data[2]),
    .I3(num0_scan_data[0]),
    .O(\Mram_num0_scan_data[3]_GND_1_o_wide_mux_81_OUT3 )
  );
  LUT4 #(
    .INIT ( 16'h5647 ))
  \Mram_num0_scan_data[3]_GND_1_o_wide_mux_81_OUT61  (
    .I0(num0_scan_data[3]),
    .I1(num0_scan_data[1]),
    .I2(num0_scan_data[2]),
    .I3(num0_scan_data[0]),
    .O(\Mram_num0_scan_data[3]_GND_1_o_wide_mux_81_OUT6 )
  );
  LUT4 #(
    .INIT ( 16'h1647 ))
  \Mram_num1_scan_data[3]_GND_1_o_wide_mux_91_OUT31  (
    .I0(num1_scan_data[3]),
    .I1(num1_scan_data[1]),
    .I2(num1_scan_data[2]),
    .I3(num1_scan_data[0]),
    .O(\Mram_num1_scan_data[3]_GND_1_o_wide_mux_91_OUT3 )
  );
  LUT4 #(
    .INIT ( 16'h5647 ))
  \Mram_num1_scan_data[3]_GND_1_o_wide_mux_91_OUT61  (
    .I0(num1_scan_data[3]),
    .I1(num1_scan_data[1]),
    .I2(num1_scan_data[2]),
    .I3(num1_scan_data[0]),
    .O(\Mram_num1_scan_data[3]_GND_1_o_wide_mux_91_OUT6 )
  );
  LUT4 #(
    .INIT ( 16'h5317 ))
  \Mram_num0_scan_data[3]_GND_1_o_wide_mux_81_OUT51  (
    .I0(num0_scan_data[3]),
    .I1(num0_scan_data[2]),
    .I2(num0_scan_data[1]),
    .I3(num0_scan_data[0]),
    .O(\Mram_num0_scan_data[3]_GND_1_o_wide_mux_81_OUT5 )
  );
  LUT4 #(
    .INIT ( 16'h5317 ))
  \Mram_num1_scan_data[3]_GND_1_o_wide_mux_91_OUT51  (
    .I0(num1_scan_data[3]),
    .I1(num1_scan_data[2]),
    .I2(num1_scan_data[1]),
    .I3(num1_scan_data[0]),
    .O(\Mram_num1_scan_data[3]_GND_1_o_wide_mux_91_OUT5 )
  );
  LUT4 #(
    .INIT ( 16'h0180 ))
  \Mcount_sec_l_xor<3>11  (
    .I0(sec_l[0]),
    .I1(sec_l[1]),
    .I2(sec_l[2]),
    .I3(sec_l[3]),
    .O(Mcount_sec_l3)
  );
  LUT4 #(
    .INIT ( 16'h0180 ))
  \Mcount_min_l_xor<3>11  (
    .I0(min_l[0]),
    .I1(min_l[1]),
    .I2(min_l[2]),
    .I3(min_l[3]),
    .O(Mcount_min_l3)
  );
  LUT4 #(
    .INIT ( 16'h1566 ))
  \Mram_num0_scan_data[3]_GND_1_o_wide_mux_81_OUT12  (
    .I0(num0_scan_data[3]),
    .I1(num0_scan_data[1]),
    .I2(num0_scan_data[0]),
    .I3(num0_scan_data[2]),
    .O(\Mram_num0_scan_data[3]_GND_1_o_wide_mux_81_OUT )
  );
  LUT4 #(
    .INIT ( 16'h150B ))
  \Mram_num0_scan_data[3]_GND_1_o_wide_mux_81_OUT111  (
    .I0(num0_scan_data[3]),
    .I1(num0_scan_data[0]),
    .I2(num0_scan_data[1]),
    .I3(num0_scan_data[2]),
    .O(\Mram_num0_scan_data[3]_GND_1_o_wide_mux_81_OUT1 )
  );
  LUT4 #(
    .INIT ( 16'h0145 ))
  \Mram_num0_scan_data[3]_GND_1_o_wide_mux_81_OUT21  (
    .I0(num0_scan_data[0]),
    .I1(num0_scan_data[1]),
    .I2(num0_scan_data[2]),
    .I3(num0_scan_data[3]),
    .O(\Mram_num0_scan_data[3]_GND_1_o_wide_mux_81_OUT2 )
  );
  LUT4 #(
    .INIT ( 16'h545F ))
  \Mram_num0_scan_data[3]_GND_1_o_wide_mux_81_OUT41  (
    .I0(num0_scan_data[3]),
    .I1(num0_scan_data[0]),
    .I2(num0_scan_data[2]),
    .I3(num0_scan_data[1]),
    .O(\Mram_num0_scan_data[3]_GND_1_o_wide_mux_81_OUT4 )
  );
  LUT4 #(
    .INIT ( 16'h1566 ))
  \Mram_num1_scan_data[3]_GND_1_o_wide_mux_91_OUT12  (
    .I0(num1_scan_data[3]),
    .I1(num1_scan_data[1]),
    .I2(num1_scan_data[0]),
    .I3(num1_scan_data[2]),
    .O(\Mram_num1_scan_data[3]_GND_1_o_wide_mux_91_OUT )
  );
  LUT4 #(
    .INIT ( 16'h150B ))
  \Mram_num1_scan_data[3]_GND_1_o_wide_mux_91_OUT111  (
    .I0(num1_scan_data[3]),
    .I1(num1_scan_data[0]),
    .I2(num1_scan_data[1]),
    .I3(num1_scan_data[2]),
    .O(\Mram_num1_scan_data[3]_GND_1_o_wide_mux_91_OUT1 )
  );
  LUT4 #(
    .INIT ( 16'h0145 ))
  \Mram_num1_scan_data[3]_GND_1_o_wide_mux_91_OUT21  (
    .I0(num1_scan_data[0]),
    .I1(num1_scan_data[1]),
    .I2(num1_scan_data[2]),
    .I3(num1_scan_data[3]),
    .O(\Mram_num1_scan_data[3]_GND_1_o_wide_mux_91_OUT2 )
  );
  LUT4 #(
    .INIT ( 16'h545F ))
  \Mram_num1_scan_data[3]_GND_1_o_wide_mux_91_OUT41  (
    .I0(num1_scan_data[3]),
    .I1(num1_scan_data[0]),
    .I2(num1_scan_data[2]),
    .I3(num1_scan_data[1]),
    .O(\Mram_num1_scan_data[3]_GND_1_o_wide_mux_91_OUT4 )
  );
  LUT5 #(
    .INIT ( 32'h37330400 ))
  Mmux_sec_h_addEn12 (
    .I0(key_row4_IBUF_5),
    .I1(set_IBUF_2),
    .I2(state_FSM_FFd2_101),
    .I3(state_FSM_FFd3_59),
    .I4(Mmux_sec_h_addEn12_222),
    .O(sec_h_addEn)
  );
  LUT6 #(
    .INIT ( 64'h3333373300000400 ))
  Mmux_sec_l_addEn11 (
    .I0(key_row4_IBUF_5),
    .I1(set_IBUF_2),
    .I2(state_FSM_FFd1_102),
    .I3(state_FSM_FFd2_101),
    .I4(state_FSM_FFd3_59),
    .I5(Mmux_sec_h_addEn11),
    .O(sec_l_addEn)
  );
  LUT6 #(
    .INIT ( 64'h8000000000000000 ))
  Mmux_sec_h_addEn111 (
    .I0(count[5]),
    .I1(count[3]),
    .I2(count[16]),
    .I3(count[15]),
    .I4(count[18]),
    .I5(count[17]),
    .O(Mmux_sec_h_addEn111_223)
  );
  LUT5 #(
    .INIT ( 32'h80000000 ))
  Mmux_sec_h_addEn112 (
    .I0(count[24]),
    .I1(count[22]),
    .I2(count[23]),
    .I3(count[9]),
    .I4(count[11]),
    .O(Mmux_sec_h_addEn112_224)
  );
  LUT6 #(
    .INIT ( 64'h0000000000008000 ))
  Mmux_sec_h_addEn113 (
    .I0(count[0]),
    .I1(count[1]),
    .I2(count[2]),
    .I3(count[4]),
    .I4(count[7]),
    .I5(count[6]),
    .O(Mmux_sec_h_addEn113_225)
  );
  LUT6 #(
    .INIT ( 64'h0000000000000001 ))
  Mmux_sec_h_addEn114 (
    .I0(count[19]),
    .I1(count[14]),
    .I2(count[13]),
    .I3(count[8]),
    .I4(count[12]),
    .I5(count[10]),
    .O(Mmux_sec_h_addEn114_226)
  );
  LUT6 #(
    .INIT ( 64'h8000000000000000 ))
  Mmux_sec_h_addEn115 (
    .I0(count[20]),
    .I1(count[21]),
    .I2(Mmux_sec_h_addEn111_223),
    .I3(Mmux_sec_h_addEn114_226),
    .I4(Mmux_sec_h_addEn113_225),
    .I5(Mmux_sec_h_addEn112_224),
    .O(Mmux_sec_h_addEn11)
  );
  LUT4 #(
    .INIT ( 16'h2622 ))
  Mmux_hour_h_addEn11 (
    .I0(hour_l[3]),
    .I1(hour_l[1]),
    .I2(hour_h[0]),
    .I3(hour_h[1]),
    .O(Mmux_hour_h_addEn1)
  );
  LUT6 #(
    .INIT ( 64'h0000008000000000 ))
  Mmux_hour_h_addEn12 (
    .I0(hour_l[0]),
    .I1(min_h[2]),
    .I2(min_h[0]),
    .I3(min_h[1]),
    .I4(hour_l[2]),
    .I5(Mmux_hour_h_addEn1),
    .O(Mmux_hour_h_addEn11_228)
  );
  LUT4 #(
    .INIT ( 16'hFFFB ))
  Mmux_hour_l_addEn1_SW0 (
    .I0(state_FSM_FFd1_102),
    .I1(set_IBUF_2),
    .I2(state_FSM_FFd3_59),
    .I3(key_row2_IBUF_3),
    .O(N01)
  );
  IBUF   reset_IBUF (
    .I(reset),
    .O(reset_IBUF_1)
  );
  IBUF   set_IBUF (
    .I(set),
    .O(set_IBUF_2)
  );
  IBUF   key_row2_IBUF (
    .I(key_row2),
    .O(key_row2_IBUF_3)
  );
  IBUF   key_row3_IBUF (
    .I(key_row3),
    .O(key_row3_IBUF_4)
  );
  IBUF   key_row4_IBUF (
    .I(key_row4),
    .O(key_row4_IBUF_5)
  );
  OBUF   num0_scan_select_3_OBUF (
    .I(num0_scan_select_3_6),
    .O(num0_scan_select[3])
  );
  OBUF   num0_scan_select_2_OBUF (
    .I(num0_scan_select_2_7),
    .O(num0_scan_select[2])
  );
  OBUF   num0_scan_select_1_OBUF (
    .I(num0_scan_select_1_8),
    .O(num0_scan_select[1])
  );
  OBUF   num0_scan_select_0_OBUF (
    .I(num0_scan_select_0_9),
    .O(num0_scan_select[0])
  );
  OBUF   num1_scan_select_1_OBUF (
    .I(num1_scan_select_1_14),
    .O(num1_scan_select[1])
  );
  OBUF   num1_scan_select_0_OBUF (
    .I(num1_scan_select_0_15),
    .O(num1_scan_select[0])
  );
  OBUF   num0_seg7_6_OBUF (
    .I(num0_seg7_6_20),
    .O(num0_seg7[6])
  );
  OBUF   num0_seg7_5_OBUF (
    .I(num0_seg7_5_21),
    .O(num0_seg7[5])
  );
  OBUF   num0_seg7_4_OBUF (
    .I(num0_seg7_4_22),
    .O(num0_seg7[4])
  );
  OBUF   num0_seg7_3_OBUF (
    .I(num0_seg7_3_23),
    .O(num0_seg7[3])
  );
  OBUF   num0_seg7_2_OBUF (
    .I(num0_seg7_2_24),
    .O(num0_seg7[2])
  );
  OBUF   num0_seg7_1_OBUF (
    .I(num0_seg7_1_25),
    .O(num0_seg7[1])
  );
  OBUF   num0_seg7_0_OBUF (
    .I(num0_seg7_0_26),
    .O(num0_seg7[0])
  );
  OBUF   num1_seg7_6_OBUF (
    .I(num1_seg7_6_27),
    .O(num1_seg7[6])
  );
  OBUF   num1_seg7_5_OBUF (
    .I(num1_seg7_5_28),
    .O(num1_seg7[5])
  );
  OBUF   num1_seg7_4_OBUF (
    .I(num1_seg7_4_29),
    .O(num1_seg7[4])
  );
  OBUF   num1_seg7_3_OBUF (
    .I(num1_seg7_3_30),
    .O(num1_seg7[3])
  );
  OBUF   num1_seg7_2_OBUF (
    .I(num1_seg7_2_31),
    .O(num1_seg7[2])
  );
  OBUF   num1_seg7_1_OBUF (
    .I(num1_seg7_1_32),
    .O(num1_seg7[1])
  );
  OBUF   num1_seg7_0_OBUF (
    .I(num1_seg7_0_33),
    .O(num1_seg7[0])
  );
  OBUF   key_col1_OBUF (
    .I(key_col1_OBUF_60),
    .O(key_col1)
  );
  OBUF   key_col2_OBUF (
    .I(state_FSM_FFd3_59),
    .O(key_col2)
  );
  LUT4 #(
    .INIT ( 16'hFFEF ))
  sec_to_min1_SW0 (
    .I0(set_IBUF_2),
    .I1(min_l[2]),
    .I2(min_l[0]),
    .I3(min_l[1]),
    .O(N2)
  );
  LUT5 #(
    .INIT ( 32'hFDFFFFFF ))
  Mmux_sec_h_addEn115_SW0 (
    .I0(count[20]),
    .I1(sec_l[1]),
    .I2(sec_l[2]),
    .I3(sec_l[3]),
    .I4(sec_l[0]),
    .O(N4)
  );
  LUT6 #(
    .INIT ( 64'h2000000000000000 ))
  Mmux_sec_h_addEn121 (
    .I0(count[21]),
    .I1(N4),
    .I2(Mmux_sec_h_addEn111_223),
    .I3(Mmux_sec_h_addEn113_225),
    .I4(Mmux_sec_h_addEn114_226),
    .I5(Mmux_sec_h_addEn112_224),
    .O(Mmux_sec_h_addEn12_222)
  );
  FDR   hour_l_0 (
    .C(clk_BUFGP_0),
    .D(hour_l_0_rstpot_260),
    .R(reset_inv),
    .Q(hour_l[0])
  );
  FDR   hour_l_1 (
    .C(clk_BUFGP_0),
    .D(hour_l_1_rstpot_261),
    .R(reset_inv),
    .Q(hour_l[1])
  );
  FDR   hour_l_3 (
    .C(clk_BUFGP_0),
    .D(hour_l_3_rstpot_262),
    .R(reset_inv),
    .Q(hour_l[3])
  );
  FDR   hour_h_0 (
    .C(clk_BUFGP_0),
    .D(hour_h_0_rstpot_263),
    .R(reset_inv),
    .Q(hour_h[0])
  );
  FDR   hour_h_1 (
    .C(clk_BUFGP_0),
    .D(hour_h_1_rstpot_264),
    .R(reset_inv),
    .Q(hour_h[1])
  );
  FDR   min_h_0 (
    .C(clk_BUFGP_0),
    .D(min_h_0_rstpot_265),
    .R(reset_inv),
    .Q(min_h[0])
  );
  FDR   min_h_1 (
    .C(clk_BUFGP_0),
    .D(min_h_1_rstpot_266),
    .R(reset_inv),
    .Q(min_h[1])
  );
  FDR   min_h_2 (
    .C(clk_BUFGP_0),
    .D(min_h_2_rstpot_267),
    .R(reset_inv),
    .Q(min_h[2])
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  hour_l_0_rstpot (
    .I0(hour_l[0]),
    .I1(hour_l_addEn),
    .O(hour_l_0_rstpot_260)
  );
  LUT5 #(
    .INIT ( 32'h31CCCCCC ))
  hour_l_1_rstpot (
    .I0(hour_l[3]),
    .I1(hour_l[1]),
    .I2(hour_l[2]),
    .I3(hour_l[0]),
    .I4(hour_l_addEn),
    .O(hour_l_1_rstpot_261)
  );
  LUT5 #(
    .INIT ( 32'h6C8CCCCC ))
  hour_l_3_rstpot (
    .I0(hour_l[1]),
    .I1(hour_l[3]),
    .I2(hour_l[0]),
    .I3(hour_l[2]),
    .I4(hour_l_addEn),
    .O(hour_l_3_rstpot_262)
  );
  LUT3 #(
    .INIT ( 8'h1C ))
  hour_h_0_rstpot (
    .I0(hour_h[1]),
    .I1(hour_h[0]),
    .I2(hour_h_addEn),
    .O(hour_h_0_rstpot_263)
  );
  LUT3 #(
    .INIT ( 8'h2C ))
  hour_h_1_rstpot (
    .I0(hour_h[0]),
    .I1(hour_h[1]),
    .I2(hour_h_addEn),
    .O(hour_h_1_rstpot_264)
  );
  LUT4 #(
    .INIT ( 16'h07F0 ))
  min_h_0_rstpot (
    .I0(min_h[2]),
    .I1(min_h[1]),
    .I2(min_h[0]),
    .I3(min_h_addEn),
    .O(min_h_0_rstpot_265)
  );
  LUT4 #(
    .INIT ( 16'h12AA ))
  min_h_1_rstpot (
    .I0(min_h[1]),
    .I1(min_h[2]),
    .I2(min_h[0]),
    .I3(min_h_addEn),
    .O(min_h_1_rstpot_266)
  );
  LUT4 #(
    .INIT ( 16'h42AA ))
  min_h_2_rstpot (
    .I0(min_h[2]),
    .I1(min_h[0]),
    .I2(min_h[1]),
    .I3(min_h_addEn),
    .O(min_h_2_rstpot_267)
  );
  LUT5 #(
    .INIT ( 32'hFFFFFF7F ))
  Mmux_hour_h_addEn121_SW0 (
    .I0(sec_h[2]),
    .I1(min_l[3]),
    .I2(sec_h[0]),
    .I3(sec_h[1]),
    .I4(N2),
    .O(N6)
  );
  LUT6 #(
    .INIT ( 64'h0400FFFF04000400 ))
  Mmux_min_h_addEn11 (
    .I0(key_row3_IBUF_4),
    .I1(set_IBUF_2),
    .I2(state_FSM_FFd2_101),
    .I3(state_FSM_FFd3_59),
    .I4(N6),
    .I5(Mmux_sec_h_addEn12_222),
    .O(min_h_addEn)
  );
  LUT4 #(
    .INIT ( 16'hFBFF ))
  Mmux_hour_h_addEn121_SW1 (
    .I0(key_row2_IBUF_3),
    .I1(state_FSM_FFd3_59),
    .I2(state_FSM_FFd2_101),
    .I3(set_IBUF_2),
    .O(N8)
  );
  LUT6 #(
    .INIT ( 64'h0D2F0F0F0F0F0F0F ))
  Mmux_hour_h_addEn13 (
    .I0(sec_h[2]),
    .I1(N2),
    .I2(N8),
    .I3(N9),
    .I4(Mmux_hour_h_addEn11_228),
    .I5(Mmux_sec_h_addEn12_222),
    .O(hour_h_addEn)
  );
  LUT6 #(
    .INIT ( 64'h1000000000000000 ))
  Mmux_hour_h_addEn121_SW3 (
    .I0(sec_h[1]),
    .I1(min_h[1]),
    .I2(min_l[3]),
    .I3(min_h[2]),
    .I4(sec_h[0]),
    .I5(min_h[0]),
    .O(N11)
  );
  LUT6 #(
    .INIT ( 64'h0CAE0C0C0C0C0C0C ))
  Mmux_hour_l_addEn1 (
    .I0(sec_h[2]),
    .I1(state_FSM_FFd2_101),
    .I2(N01),
    .I3(N2),
    .I4(N11),
    .I5(Mmux_sec_h_addEn12_222),
    .O(hour_l_addEn)
  );
  LUT3 #(
    .INIT ( 8'hCA ))
  hour_l_2_rstpot (
    .I0(hour_l[2]),
    .I1(Mcount_hour_l2),
    .I2(hour_l_addEn),
    .O(hour_l_2_rstpot_272)
  );
  FDR   hour_l_2 (
    .C(clk_BUFGP_0),
    .D(hour_l_2_rstpot_272),
    .R(reset_inv),
    .Q(hour_l[2])
  );
  MUXF7   Mmux_hour_h_addEn121_SW2 (
    .I0(N13),
    .I1(N14),
    .S(state_FSM_FFd3_59),
    .O(N9)
  );
  LUT3 #(
    .INIT ( 8'hF7 ))
  Mmux_hour_h_addEn121_SW2_F (
    .I0(sec_h[0]),
    .I1(min_l[3]),
    .I2(sec_h[1]),
    .O(N13)
  );
  LUT6 #(
    .INIT ( 64'hAAA2FFF3FFF3FFF3 ))
  Mmux_hour_h_addEn121_SW2_G (
    .I0(sec_h[1]),
    .I1(set_IBUF_2),
    .I2(state_FSM_FFd2_101),
    .I3(key_row2_IBUF_3),
    .I4(sec_h[0]),
    .I5(min_l[3]),
    .O(N14)
  );
  MUXF7   Mmux_min_l_addEn11 (
    .I0(N15),
    .I1(N16),
    .S(set_IBUF_2),
    .O(min_l_addEn)
  );
  LUT4 #(
    .INIT ( 16'h2000 ))
  Mmux_min_l_addEn11_F (
    .I0(sec_h[0]),
    .I1(sec_h[1]),
    .I2(sec_h[2]),
    .I3(Mmux_sec_h_addEn12_222),
    .O(N15)
  );
  LUT4 #(
    .INIT ( 16'h0010 ))
  Mmux_min_l_addEn11_G (
    .I0(key_row3_IBUF_4),
    .I1(state_FSM_FFd3_59),
    .I2(state_FSM_FFd2_101),
    .I3(state_FSM_FFd1_102),
    .O(N16)
  );
  BUFGP   clk_BUFGP (
    .I(clk),
    .O(clk_BUFGP_0)
  );
  INV   reset_inv1_INV_0 (
    .I(reset_IBUF_1),
    .O(reset_inv)
  );
  INV   \count[11]_INV_21_o1_INV_0  (
    .I(count[11]),
    .O(\count[11]_INV_21_o )
  );
  INV   \Mcompar_count[24]_PWR_1_o_LessThan_2_o_cy<4>_inv1_INV_0  (
    .I(\Mcompar_count[24]_PWR_1_o_LessThan_2_o_cy<4>_220 ),
    .O(\count[24]_PWR_1_o_LessThan_2_o_inv_inv )
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

