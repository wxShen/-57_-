module SignExt(cin,extcin);
input[15:0]  cin; 
output [31:0] extcin;
	
	assign extcin = {{16{cin[15]}}, cin};
	
endmodule
