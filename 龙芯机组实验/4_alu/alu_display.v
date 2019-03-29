//*************************************************************************
//   > �ļ���: alu_display.v
//   > ����  ��ALU��ʾģ�飬����FPGA���ϵ�IO�ӿںʹ�����
//   > ����  : LOONGSON
//   > ����  : 2016-04-14
//*************************************************************************
module alu_display(
    //ʱ���븴λ�ź�
     input clk,
    input resetn,    //��׺"n"����͵�ƽ��Ч

    //���뿪�أ�����ѡ��������
    input [2:0] input_sel, //000:����Ϊ�����ź�(alu_control)
                           //010:����ΪԴ������1(alu_src1)
                           //011:����ΪԴ������2(alu_src2)

    //��������ؽӿڣ�����Ҫ����
    output lcd_rst,
    output lcd_cs,
    output lcd_rs,
    output lcd_wr,
    output lcd_rd,
    inout[15:0] lcd_data_io,
    output lcd_bl_ctr,
    inout ct_int,
    inout ct_sda,
    output ct_scl,
    output ct_rstn
    );
//-----{����ALUģ��}begin
    reg   [11:0] alu_control;  // ALU�����ź�
    reg   [63:0] alu_src1;     // ALU������1
	 reg   [31:0] alu_src1_L,alu_src1_H;
    reg   [63:0] alu_src2;  	 // ALU������2
	 reg   [31:0] alu_src2_L,alu_src2_H;
    wire   [63:0] alu_result;   // ALU���
	 wire   [31:0] alu_result_L,alu_result_H;
    /*alu alu_module(
        .alu_control(alu_control),
        .alu_src1   (alu_src1   ),
        .alu_src2   (alu_src2   ),
        .alu_result (alu_result )
    );*/
	  alu alu_module(
        .alu_control(alu_control),
        .alu_src1   ({alu_src1_H,alu_src1_L} ),
        .alu_src2   ({alu_src2_H,alu_src2_L} ),
        .alu_result (alu_result )
    );
	 //assign  alu_result_L = alu_result[31:0];//
	 //assign  alu_result_H = alu_result[63:32];//
	 assign {alu_result_H,alu_result_L} = alu_result ;
//-----{����ALUģ��}end

//---------------------{���ô�����ģ��}begin--------------------//
//-----{ʵ����������}begin
//��С�ڲ���Ҫ����
    reg         display_valid;
    reg  [39:0] display_name;
    reg  [31:0] display_value;
    wire [5 :0] display_number;
    wire        input_valid;
    wire [31:0] input_value;
	 
    lcd_module lcd_module(
        .clk            (clk           ),   //10Mhz
        .resetn         (resetn        ),

        //���ô������Ľӿ�
        .display_valid  (display_valid ),
        .display_name   (display_name  ),
        .display_value  (display_value ),
        .display_number (display_number),
        .input_valid    (input_valid   ),
        .input_value    (input_value   ),

        //lcd��������ؽӿڣ�����Ҫ����
        .lcd_rst        (lcd_rst       ),
        .lcd_cs         (lcd_cs        ),
        .lcd_rs         (lcd_rs        ),
        .lcd_wr         (lcd_wr        ),
        .lcd_rd         (lcd_rd        ),
        .lcd_data_io    (lcd_data_io   ),
        .lcd_bl_ctr     (lcd_bl_ctr    ),
        .ct_int         (ct_int        ),
        .ct_sda         (ct_sda        ),
        .ct_scl         (ct_scl        ),
        .ct_rstn        (ct_rstn       )
    ); 
//-----{ʵ����������}end

//-----{�Ӵ�������ȡ����}begin
//����ʵ����Ҫ��������޸Ĵ�С�ڣ�
//�����ÿһ���������룬��д����һ��always��
    //��input_selΪ000ʱ����ʾ�����������źţ���alu_control
    always @(posedge clk)
    begin
        if (!resetn)
        begin
            alu_control <= 12'd0;
        end
        else if (input_valid && input_sel==3'b000)
        begin
            alu_control <= input_value[11:0];
        end
    end
    
    //��input_selΪ001ʱ����ʾ������ΪԴ������1����alu_src1
    always @(posedge clk)
    begin
        if (!resetn)
        begin
            alu_src1 <= 32'd0;
        end
        else if (input_valid && input_sel==3'b001)
        begin
            alu_src1_L <= input_value;
        end
    end
	  //��input_selΪ010ʱ����ʾ������ΪԴ������1����alu_src1
    always @(posedge clk)
    begin
        if (!resetn)
        begin
            alu_src1 <= 32'd0;
        end
        else if (input_valid && input_sel==3'b010)
        begin
            alu_src1_H <= input_value;
        end
    end
	 
	assign alu_scr1 = {alu_src1_H,alu_src1_L};
	
	  //��input_selΪ110ʱ����ʾ������ΪԴ������1����alu_src2
    always @(posedge clk)
    begin
        if (!resetn)
        begin
            alu_src1 <= 32'd0;
        end
        else if (input_valid && input_sel==3'b101)
        begin
            alu_src2_L <= input_value;
        end
    end
	  //��input_selΪ111ʱ����ʾ������ΪԴ������1����alu_src1
    always @(posedge clk)
    begin
        if (!resetn)
        begin
            alu_src1 <= 32'd0;
        end
        else if (input_valid && input_sel==3'b110)
        begin
            alu_src2_H <= input_value;
        end
    end
	 
	assign alu_scr2 = {alu_src2_H,alu_src2_L};
	
//-----{�Ӵ�������ȡ����}end

//-----{�������������ʾ}begin
//������Ҫ��ʾ�����޸Ĵ�С�ڣ�
//�������Ϲ���44����ʾ���򣬿���ʾ44��32λ����
//44����ʾ�����1��ʼ��ţ����Ϊ1~44��
    always @(posedge clk)
    begin
        case(display_number)
            6'd1 :
            begin
                display_valid <= 1'b1;
                display_name  <= "SRC_1_L";
                display_value <= alu_src1_L;
            end
            6'd2 :
            begin
                display_valid <= 1'b1;
                display_name  <= "SRC_1_H";
                display_value <= alu_src1_H;
            end
            6'd3 :
            begin
                display_valid <= 1'b1;
                display_name  <= "SRC_2_L";
                display_value <=alu_src2_L;
            end
            6'd4 :
            begin
                display_valid <= 1'b1;
                display_name  <= "SRC_2_H";
                display_value <= alu_src2_H;
            end
				 6'd5 :
            begin
                display_valid <= 1'b1;
                display_name  <= "CONTR";
                display_value <={20'd0, alu_control};
            end
				 6'd6 :
            begin
                display_valid <= 1'b1;
                display_name  <= "RESULT_L";
                display_value <=alu_result_L;
            end
				6'd7 :
				begin
                display_valid <= 1'b1;
                display_name  <= "RESULT_H";
                display_value <= alu_result_H;
            end
            default :
            begin
                display_valid <= 1'b0;
                display_name  <= 40'd0;
                display_value <= 32'd0;
            end
        endcase
    end
//-----{�������������ʾ}end
//----------------------{���ô�����ģ��}end---------------------//
endmodule
