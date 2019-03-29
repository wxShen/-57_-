module dm_4k(addr,din,mem_ctrl,clk,dout);//数据存储器 //mem_ctrl <= {inst_load,inst_store,lb_sign,ls_word}
	input clk;	//clock
	input [11:0] addr;		//address bus
	input [31:0] din;		//32-bit input data
	input [4:0] mem_ctrl;	//memory write enable		
	output [31:0] dout;		//32-bit memory output

	reg[31:0] Dm[1023:0];
	integer i;
	initial
		begin
			for(i=0;i<1024;i=i+1)
				Dm[i] = 32'b0;
		end
	
	reg [3:0] dm_wen;
	wire inst_load;  	//load操作
    wire inst_store; 	//store操作
    wire[1:0] ls_word;   //load/store为字节还是字,0:byte;1:word
    wire lb_sign;    	//load一字节为有符号load
    assign {inst_load,inst_store,ls_word,lb_sign} = mem_ctrl;

	//store操作的写使能
	always @ (|inst_store)  // 访存级有效时,且为store操作  // 内存写使能信号
     	begin
            if (ls_word==2'b10)
	            begin
	                dm_wen <= 4'b1111; // 存储字指令，写使能全1
	            end
	        else if(ls_word == 2'b01)
	            begin // SH指令，需要依据地址底两位，确定对应的写使能
	                case (addr[1:0])
	                    2'b00   : dm_wen <= 4'b0011;
	                    2'b10   : dm_wen <= 4'b1100;
	                    default : dm_wen <= 4'b0000;
	                endcase 
                end
            else if(ls_word == 2'b00)
	            begin // SB指令，需要依据地址底两位，确定对应的写使能
	                case (addr[1:0])
	                    2'b00   : dm_wen <= 4'b0001;
	                    2'b01   : dm_wen <= 4'b0010;
	                    2'b10   : dm_wen <= 4'b0100;
	                    2'b11   : dm_wen <= 4'b1000;
	                    default : dm_wen <= 4'b0000;
	                endcase
                end
            else
                begin
                    dm_wen <= 4'b0000;
                end
         end
    //store操作的写数据
    always @(negedge clk)    // 当写控制信号为1，数据写入内存
    begin
        if (dm_wen[3])
        begin
            Dm[addr][31:24] <= din[31:24];
        end
    end
    always @(negedge clk)
    begin
        if (dm_wen[2])
        begin
            Dm[addr][23:16] <= din[23:16];
        end
    end
    always @(negedge clk)
    begin
        if (dm_wen[1])
        begin
            Dm[addr][15: 8] <= din[15: 8];
        end
    end
    always @(negedge clk)
    begin
        if (dm_wen[0])
        begin
            Dm[addr][7 : 0] <= din[7 : 0];
        end
    end
   
    //load读出的数据
    wire [31:0] dm_rdata;
     assign dm_rdata = Dm[addr[11:2]];//每条指令均为4个字节 inst_load  =lw | lb | lbu | lh | lhu; // load指令
     wire  loadb_sign,loadh_sign;
     wire [31:0] lb_result;
     wire [31:0] lh_result;
    assign loadb_sign =   (addr[1:0]==2'd0) ? dm_rdata[ 7] :
                       (addr[1:0]==2'd1) ? dm_rdata[15] :
                       (addr[1:0]==2'd2) ? dm_rdata[23] : dm_rdata[31] ;

    assign loadh_sign =  (addr[1:0]==2'd0) ? dm_rdata[ 15] : (addr[1:0]==2'd1) ? dm_rdata[31] : 0;   

    assign lb_result[7:0] = (addr[1:0]==2'd0) ? dm_rdata[ 7:0 ] :
                            (addr[1:0]==2'd1) ? dm_rdata[15:8 ] :
                            (addr[1:0]==2'd2) ? dm_rdata[23:16] : dm_rdata[31:24];
    assign lh_result[16:0] = (addr[1:0]==2'd0) ? dm_rdata[ 15:0 ] : (addr[1:0]==2'd1) ? dm_rdata[31:16] : 16'd0;                                               
    assign lb_result[31:8] = {24{lb_sign & loadb_sign}};
    assign lh_result[31:16]= {16{lb_sign & loadh_sign}};
    assign dout = (ls_word == 2'b00) ? lb_result : (ls_word == 2'b01) ? lh_result : dm_rdata;
endmodule // dm_4k

    
   
    
    