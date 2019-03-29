`timescale 1ns / 1ps
//*************************************************************************
//   > 文件名: multi_cycle_cpu.v
//   > 描述  :多周期CPU模块，共实现36条指令
//   >        指令rom和数据ram均实例化xilinx IP得到，为同步读写
//   > 作者  : LOONGSON
//   > 日期  : 2016-04-14
//*************************************************************************
module multi_cycle_cpu(  // 多周期cpu
    input clk,           // 时钟
    input resetn,        // 复位信号，低电平有效
    
    //display data
    input  [ 4:0] rf_addr,
    input  [31:0] mem_addr,
    output [31:0] rf_data,
    output [31:0] mem_data,
    output [31:0] IF_pc,
    output [31:0] IF_inst,
    output [31:0] ID_pc,
    output [31:0] EXE_pc,
    output [31:0] MEM_pc,
    output [31:0] WB_pc,
    output [31:0] display_state
    );
//----------------------{控制多周期的状态机}begin------------------------//
    reg [2:0] state;       // 当前状态
    reg [2:0] next_state;  // 下一状态

    //展示当前处理器正在执行哪个模块
    assign display_state = {29'd0,state};
    // 状态机状态
    parameter IDLE   = 3'd0;  // 开始
    parameter FETCH  = 3'd1;  // 取指
    parameter DECODE = 3'd2;  // 译码
    parameter EXE    = 3'd3;  // 执行
    parameter MEM    = 3'd4;  // 访存
    parameter WB     = 3'd5;  // 写回

    always @ (posedge clk)        // 当前状态
    begin
        if (!resetn) begin        // 如果复位信号有效
            state <= IDLE;       // 当前状态为 开始
        end
        else begin                // 否则
            state <= next_state;  // 为下一状态
        end
    end

    wire IF_over;     // IF模块已执行完
    wire ID_over;     // ID模块已执行完
    wire EXE_over;    // EXE模块已执行完
    wire MEM_over;    // MEM模块已执行完
    wire WB_over;     // WB模块已执行完
    wire jbr_not_link;//分支指令(非link类)，只走IF和ID级
    always @ (*)                             // 下一状态 
    begin
        case (state)
            IDLE : 
            begin
                next_state = FETCH;    // 开始->取指
            end
            FETCH: 
            begin
                if (IF_over)
                begin
                    next_state = DECODE;   // 取指->译码
                end
                else
                begin
                    next_state = FETCH;    // 取指->译码
                end
            end
            DECODE: 
            begin
                if (ID_over)
                begin                      // 译码->执行或取指   
                    next_state = jbr_not_link ? FETCH : EXE;
                end
                else
                begin
                    next_state = DECODE;   // 取指->译码
                end
            end
            EXE: 
            begin
                if (EXE_over)
                begin
                    next_state = MEM;      // 执行->访存
                end
                else
                begin
                    next_state = EXE;   // 取指->译码
                end
            end
            MEM:
            begin
                if (MEM_over)
                begin
                    next_state = WB;       // 访存->写回
                end
                else
                begin
                    next_state = MEM;   // 取指->译码
                end
            end
            WB:
            begin
                if (WB_over)
                begin
                    next_state = FETCH;    // 写回->取指
                end
                else
                begin
                    next_state = WB;   // 取指->译码
                end
            end
            default : next_state = IDLE;
        endcase
    end
    //5模块的valid信号
    wire IF_valid;
    wire ID_valid;
    wire EXE_valid;
    wire MEM_valid;
    wire WB_valid;
    assign  IF_valid = (state == FETCH );  // 当前状态为取指时，IF级有效
    assign  ID_valid = (state == DECODE);  // 当前状态为译码时，ID级有效
    assign EXE_valid = (state == EXE   );  // 当前状态为执行时，EXE级有效
    assign MEM_valid = (state == MEM   );  // 当前状态为访存时，MEM级有效
    assign  WB_valid = (state == WB    );  // 当前状态为写回时，WB级有效
//-----------------------{控制多周期的状态机}end-------------------------//

//--------------------------{5级间的总线}begin---------------------------//
    wire [ 63:0] IF_ID_bus;   // IF->ID级总线
    wire [149:0] ID_EXE_bus;  // ID->EXE级总线
    wire [105:0] EXE_MEM_bus; // EXE->MEM级总线
    wire [ 69:0] MEM_WB_bus;  // MEM->WB级总线
    
    //锁存以上总线信号
    reg [ 63:0] IF_ID_bus_r;
    reg [149:0] ID_EXE_bus_r;
    reg [105:0] EXE_MEM_bus_r;
    reg [ 69:0] MEM_WB_bus_r;
    
    //IF到ID的锁存信号
    always @(posedge clk)
    begin
        if(IF_over)
        begin
            IF_ID_bus_r <= IF_ID_bus;
        end
    end
    //ID到EXE的锁存信号
    always @(posedge clk)
    begin
        if(ID_over)
        begin
            ID_EXE_bus_r <= ID_EXE_bus;
        end
    end
    //EXE到MEM的锁存信号
    always @(posedge clk)
    begin
        if(EXE_over)
        begin
            EXE_MEM_bus_r <= EXE_MEM_bus;
        end
    end    
    //MEM到WB的锁存信号
    always @(posedge clk)
    begin
        if(MEM_over)
        begin
            MEM_WB_bus_r <= MEM_WB_bus;
        end
    end
//---------------------------{5级间的总线}end----------------------------//

//--------------------------{其他交互信号}begin--------------------------//
    //跳转总线
    wire [ 32:0] jbr_bus;    

    //IF与inst_rom交互
    wire [31:0] inst_addr;
    wire [31:0] inst;

    //MEM与data_ram交互    
    wire [ 3:0] dm_wen;
    wire [31:0] dm_addr;
    wire [31:0] dm_wdata;
    wire [31:0] dm_rdata;

    //ID与regfile交互
    wire [ 4:0] rs;
    wire [ 4:0] rt;   
    wire [31:0] rs_value;
    wire [31:0] rt_value;
    
    //WB与regfile交互
    wire        rf_wen;
    wire [ 4:0] rf_wdest;
    wire [31:0] rf_wdata;    
//---------------------------{其他交互信号}end---------------------------//

//-------------------------{各模块实例化}begin---------------------------//
    wire next_fetch; //即将运行取指模块，需要先锁存PC值
    //当前状态为decode，且指令为跳转分支指令(非link类)，且decode执行完成
    //或者，当前状态为wb，且wb执行完成，则即将进入fetch状态
    assign next_fetch = (state==DECODE & ID_over & jbr_not_link)
                      | (state==WB     & WB_over);
    fetch IF_module(             // 取指级
        .clk       (clk       ),  // I, 1
        .resetn    (resetn    ),  // I, 1
        .IF_valid  (IF_valid  ),  // I, 1
        .next_fetch(next_fetch),  // I, 1
        .inst      (inst      ),  // I, 32
        .jbr_bus   (jbr_bus   ),  // I, 33
        .inst_addr (inst_addr ),  // O, 32
        .IF_over   (IF_over   ),  // O, 1
        .IF_ID_bus (IF_ID_bus ),  // O, 64
        
        //展示PC和取出的指令
        .IF_pc     (IF_pc     ),
        .IF_inst   (IF_inst   )
    );

    decode ID_module(               // 译码级
        .ID_valid    (ID_valid    ),  // I, 1
        .IF_ID_bus_r (IF_ID_bus_r ),  // I, 64
        .rs_value    (rs_value    ),  // I, 32
        .rt_value    (rt_value    ),  // I, 32
        .rs          (rs          ),  // O, 5
        .rt          (rt          ),  // O, 5
        .jbr_bus     (jbr_bus     ),  // O, 33
        .jbr_not_link(jbr_not_link),  // O, 1
        .ID_over     (ID_over     ),  // O, 1
        .ID_EXE_bus  (ID_EXE_bus  ),  // O, 150
        
        //展示PC
        .ID_pc      (ID_pc      )
    );

    exe EXE_module(                   // 执行级
        .EXE_valid   (EXE_valid   ),  // I, 1
        .ID_EXE_bus_r(ID_EXE_bus_r),  // I, 150
        .EXE_over    (EXE_over    ),  // O, 1 
        .EXE_MEM_bus (EXE_MEM_bus ),  // O, 106
        
        //展示PC
        .EXE_pc      (EXE_pc      )
    );

    mem MEM_module(                     // 访存级
        .clk          (clk          ),  // I, 1 
        .MEM_valid    (MEM_valid    ),  // I, 1
        .EXE_MEM_bus_r(EXE_MEM_bus_r),  // I, 106
        .dm_rdata     (dm_rdata     ),  // I, 32
        .dm_addr      (dm_addr      ),  // O, 32
        .dm_wen       (dm_wen       ),  // O, 4 
        .dm_wdata     (dm_wdata     ),  // O, 32
        .MEM_over     (MEM_over     ),  // O, 1
        .MEM_WB_bus   (MEM_WB_bus   ),  // O, 70
        
        //展示PC
        .MEM_pc       (MEM_pc       )
    );          
 
    wb WB_module(                     // 写回级
        .WB_valid    (WB_valid    ),  // I, 1
        .MEM_WB_bus_r(MEM_WB_bus_r),  // I, 70
        .rf_wen      (rf_wen      ),  // O, 1
        .rf_wdest    (rf_wdest    ),  // O, 5
        .rf_wdata    (rf_wdata    ),  // O, 32
        .WB_over     (WB_over     ),  // O, 1
        
        //展示PC
        .WB_pc       (WB_pc       )
    );

    inst_rom inst_rom_module(         // 指令存储器
        .clka       (clk           ),  // I, 1 ,时钟
        .addra      (inst_addr[9:2]),  // I, 8 ,指令地址
        .douta      (inst          )   // O, 32,指令
    );

    regfile rf_module(        // 寄存器堆模块
        .clk    (clk      ),  // I, 1
        .wen    (rf_wen   ),  // I, 1
        .raddr1 (rs       ),  // I, 5
        .raddr2 (rt       ),  // I, 5
        .waddr  (rf_wdest ),  // I, 5
        .wdata  (rf_wdata ),  // I, 32
        .rdata1 (rs_value ),  // O, 32
        .rdata2 (rt_value ),  // O, 32

        //display rf
        .test_addr(rf_addr),
        .test_data(rf_data)
    );
    
    data_ram data_ram_module(   // 数据存储模块
        .clka   (clk         ),  // I, 1,  时钟
        .wea    (dm_wen      ),  // I, 1,  写使能
        .addra  (dm_addr[9:2]),  // I, 8,  读地址
        .dina   (dm_wdata    ),  // I, 32, 写数据
        .douta  (dm_rdata    ),  // O, 32, 读数据

        //display mem
        .clkb   (clk          ),
        .web    (4'd0         ),
        .addrb  (mem_addr[9:2]),
        .doutb  (mem_data     ),
        .dinb   (32'd0        )
    );
//--------------------------{各模块实例化}end----------------------------//
endmodule
