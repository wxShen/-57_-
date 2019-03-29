//*************************************************************************
//   > �ļ���: lcd_module.v
//   > ����  ��lcd������ģ�飬Ϊ�ں��ļ�
//   > ����  : LOONGSON
//   > ����  : 2016-04-14
//*************************************************************************
//synthesis attribute box_type <lcd_module> "black_box" 
module lcd_module(
    input  clk,      //����10Mhz��ʱ��
    input  resetn,   //��ʹ��

    //���ô������Ľӿ�
    input display_valid,
    input [39:0] display_name,
    input [31:0] display_value,
    output [5:0] display_number,
    output        input_valid,
    output [31:0] input_value,

    //lcd��������ؽӿڣ�����Ҫ����
    output reg   lcd_rst,
    output       lcd_cs,
    output       lcd_rs,
    output       lcd_wr,
    output       lcd_rd,
    inout [15:0] lcd_data_io,
    output       lcd_bl_ctr,
    inout        ct_int,
    inout        ct_sda,
    output       ct_scl,
    output       ct_rstn
    ); 
endmodule
