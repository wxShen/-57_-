module Mux_tb ();
	reg [1:0] i_Select;
    reg [31:0] i_Data1,i_Data2,i_Data3,i_Data4;
    wire [31:0]  o_Data;

    initial begin
    	i_Select =2'b0;
    	i_Data1 =1;
    	i_Data2 =2;
    	i_Data3 =3;
    	i_Data4 =4;
    	#100;
    end
    always #100 i_Select =(i_Select+ 1) %4;
    Mux_4_To_1 #32 mux(i_Select,i_Data1,i_Data2,i_Data3,i_Data4);
endmodule