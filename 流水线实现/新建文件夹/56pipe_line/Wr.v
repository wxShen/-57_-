`define EXC_ENTER_ADDR 32'd0     // Excption入口地址，
module Wr (clk,wb_ctrl,hi_write,lo_write,lo_result,rf_addr,mem_result,pc,alu_result,RegWr,busw,exc_bus,if_cancel,Rw);//wb_ctrl <={mfhi,mflo,mtc0,mfc0,syscall,Break,eret,cp0r_addr,RegWr,MemtoReg}
//MEM传来的result
    input [31:0] mem_result,alu_result,pc;
    input [31:0] lo_result; //HI/LO数据 
    input        hi_write;
    input        lo_write;
    input       clk;
    input [16:0] wb_ctrl;
    input [31:0] pc; //pc
    input [4:0] rf_addr;
    //寄存器堆写使能和写地址
    output RegWr,if_cancel;
    output [4:0] Rw;
    output [31:0] busw;
    output [32:0] exc_bus;
    //写回需要用到的信息
    reg exc_vaild;
    wire mfhi;
    wire mflo;
    wire mtc0;
    wire mfc0;
    wire [7 :0] cp0r_addr;
    wire Break;//对于break指令暂时还未能实现；
    wire       syscall;   //syscall和eret在写回级有特殊的操作 
    wire       eret;

    assign { mfhi,mflo,mtc0,mfc0,syscall,Break,eret,cp0r_addr,RegWr,MemtoReg } = wb_ctrl ;
    assign Rw = rf_addr;
//-----{HI/LO寄存器}begin
    //HI用于存放乘法结果的高32位
    //LO用于存放乘法结果的低32位
    reg [31:0] hi;
    reg [31:0] lo;
    
    initial 
      begin
        hi <= 32'd0;
        lo <= 32'd0;
      end
    //要写入HI的数据存放在mem_result里
    always @(posedge clk)
    begin
        if (hi_write)
        begin
            hi <= alu_result;
        end
    end
    //要写入LO的数据存放在lo_result里
    always @(posedge clk)
    begin
        if (lo_write)
        begin
            lo <= lo_result;
        end
    end
//-----{HI/LO寄存器}end
//-----{cp0寄存器}begin
// cp0寄存器即是协处理器0寄存器
// 由于目前设计的CPU并不完备，所用到的cp0寄存器也很少
// 故暂时只实现STATUS(12.0),CAUSE(13.0),EPC(14.0)这三个
// 每个CP0寄存器都是使用5位的cp0号
   wire [31:0] cp0r_status;
   wire [31:0] cp0r_cause;
   wire [31:0] cp0r_epc;
   
   //写使能
   wire status_wen;
   //wire cause_wen;
   wire epc_wen;
   assign status_wen = mtc0 & (cp0r_addr=={5'd12,3'd0});
   assign epc_wen    = mtc0 & (cp0r_addr=={5'd14,3'd0});

   //EPC寄存器
   //存放产生例外的地址
   //EPC整个域为软件可读写的，故需要epc_wen
   reg [31:0] epc_r;
   assign cp0r_epc = epc_r;
   always @(posedge clk)
   begin
       if (syscall)
       begin
           epc_r <= pc;
       end
       else if (epc_wen)
       begin
           epc_r <= alu_result;
       end
   end
   
   //cp0寄存器读
   wire [31:0] cp0r_rdata;
   assign cp0r_rdata = (cp0r_addr=={5'd12,3'd0}) ? cp0r_status :
                       (cp0r_addr=={5'd13,3'd0}) ? cp0r_cause  :
                       (cp0r_addr=={5'd14,3'd0}) ? cp0r_epc : 32'd0;
   
   //STATUS寄存器
   //目前只实现STATUS[1]位，即EXL域
   //EXL域为软件可读写，故需要statu_wen
   reg status_exl_r;
   assign cp0r_status = {30'd0,status_exl_r,1'b0};
   always @(posedge clk)
   begin
       if (eret)
       begin
           status_exl_r <= 1'b0;
       end
       else if (syscall)
       begin
           status_exl_r <= 1'b1;
       end
       else if (status_wen)
       begin
           status_exl_r <= alu_result[1];
       end
   end
   
   //CAUSE寄存器
   //目前只实现CAUSE[6:2]位，即ExcCode域,存放Exception编码
   //ExcCode域为软件只读，不可写，故不需要cause_wen
   reg [4:0] cause_exc_code_r;
  
   initial
   begin
    exc_vaild = 0;
    epc_r = 32'd0;
    status_exl_r = 0;
    cause_exc_code_r = 5'd0;
  end

   assign cp0r_cause = {25'd0,cause_exc_code_r,2'd0};
   always @(posedge clk)
   begin
       if (syscall)
       begin
           cause_exc_code_r <= 5'd8;
       end
   end
   
   //syscall和eret发出的cancel信号
   assign if_cancel = syscall || eret;
//-----{cp0寄存器}begin

//-----{WB->regfile信号}begin
    assign busw = mfhi ? hi :
                      mflo ? lo :
                      mfc0 ? cp0r_rdata : 
                  MemtoReg ? mem_result : alu_result;
//-----{WB->regfile信号}end

//-----{Exception pc信号}begin
    //eret返回地址为EPC寄存器的值
    //SYSCALL的excPC应该为{EBASE[31:10],10'h180},
    //但作为实验，先设置EXC_ENTER_ADDR为0，方便测试程序的编写
    assign exc_pc = syscall ? `EXC_ENTER_ADDR : cp0r_epc;
    assign exc_bus = {exc_vaild,exc_pc}; 
    always @(negedge clk)
    	begin
    		if(if_cancel)
    		begin
    			exc_vaild <= 1;
    		end
    		else
    		begin
    			exc_vaild <=0;
    		end
    	end
endmodule