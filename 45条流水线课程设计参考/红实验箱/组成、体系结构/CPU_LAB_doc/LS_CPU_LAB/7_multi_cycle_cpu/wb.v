`timescale 1ns / 1ps
//*************************************************************************
//   > �ļ���: wb.v
//   > ����  :������CPU��д��ģ��
//   > ����  : LOONGSON
//   > ����  : 2016-04-14
//*************************************************************************
module wb(                      // д�ؼ�
    input         WB_valid,     // д�ؼ���Ч
    input  [69:0] MEM_WB_bus_r, // MEM->WB����
    output        rf_wen,       // �Ĵ���дʹ��
    output [ 4:0] rf_wdest,     // �Ĵ���д��ַ
    output [31:0] rf_wdata,     // �Ĵ���д����
    output        WB_over,      // WBģ��ִ�����

    //չʾPC
    output [ 31:0] WB_pc
);
//-----{MEM->WB����}begin    
    //�Ĵ�����дʹ�ܺ�д��ַ
    wire wen;
    wire [4:0] wdest;
    
    //MEM������result
    wire [31:0] mem_result;
    
    //pc
    wire [31:0] pc;    
    assign {wen,wdest,mem_result,pc} = MEM_WB_bus_r;
//-----{MEM->WB����}end

//-----{WBִ�����}begin
    //WBģ��ֻ�Ǵ��ݼĴ����ѵ�дʹ��/д��ַ��д����
    //����һ�������
    //��WB_valid����WB_over�ź�
    assign WB_over = WB_valid;
//-----{WBִ�����}end

//-----{WB->regfile�ź�}begin
    assign rf_wen   = wen & WB_valid;
    assign rf_wdest = wdest;
    assign rf_wdata = mem_result;
//-----{WB->regfile�ź�}end

//-----{չʾWBģ���PCֵ}begin
    assign WB_pc = pc;
//-----{չʾWBģ���PCֵ}end
endmodule

