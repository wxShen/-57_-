module testbench();
    
    reg clk, rst;
    
    initial 
    begin
    clk = 1'b0;  rst = 1'b1;
    #20 rst = 1'b0;
    end

    always #10 clk = ~clk;
    mips MIPS(clk,rst);
endmodule
