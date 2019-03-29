module Mux_2_To_1 (input  i_Select,
                   input  i_Data1,
                   input  i_Data2,
                   output o_Data);
 
  assign o_Data = (i_Select==0) ? i_Data1 : i_Data2;
 
endmodule // Mux_2_To_1

module Mux_2_To_1_Width #(parameter g_WIDTH = 8)
  (input  i_Select,
   input  [g_WIDTH-1:0] i_Data1,
   input  [g_WIDTH-1:0] i_Data2,
   output [g_WIDTH-1:0] o_Data);
   
  assign o_Data = (i_Select == 0) ? i_Data1 : i_Data2;
   
endmodule // Mux_2_To_1_Width

module Mux_4_To_1 #(parameter g_WIDTH = 8)
	(input [1:0] i_Select,
   input [g_WIDTH-1:0] i_Data1,
   input [g_WIDTH-1:0] i_Data2,
   input [g_WIDTH-1:0] i_Data3,
   input [g_WIDTH-1:0] i_Data4,
   output [g_WIDTH-1:0] o_Data);
 
  reg [g_WIDTH-1:0] r_Data;
   
assign o_Data = i_Select[1] ? (i_Select[0] ? i_Data4 : i_Data3) :
                              (i_Select[0] ? i_Data2 : i_Data1);

// Alternatively:
always @(*)
begin
  case (i_Select)
    2'b00 : r_Data <= i_Data1;
    2'b01 : r_Data <= i_Data2;
    2'b10 : r_Data <= i_Data3;
    2'b11 : r_Data <= i_Data4;
  endcase // case (i_Select)
end

assign o_Data = r_Data;
     
endmodule // Mux_4_To_1