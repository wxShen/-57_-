module ForwardingUnit(RegWr1,RegWr2,Rs,Rt,Rd1,Rd2,ForwardA,ForwardB);
	input[4:0] Rs,Rt,Rd1,Rd2;
	input RegWr1,RegWr2;
	output reg[1:0] ForwardA,ForwardB;

	always @( RegWr1 or Rd1 or Rs or RegWr2 or Rd2) begin
		if (RegWr1 & (Rd1 != 0) & (Rd1 == Rs)) begin  //不知道!是否可以用
			ForwardA = 10;
			
		end
		else if (RegWr2 & (Rd2 != 0) & (Rd2 == Rs) & ~(RegWr1 & (Rd1 != 0) & (Rd1 == Rs))) begin 
			ForwardA = 01;
			
		end
		else begin
			ForwardA = 00;
		end
	end

	always @( RegWr1 or Rd1 or Rt or RegWr2 or Rd2) begin
		if (RegWr1 & (Rd1 != 0) & (Rd1 == Rt)) begin 
			ForwardB = 10;
			
		end
		else if (RegWr2 & (Rd2 != 0) & (Rd2 == Rt) & ~(RegWr1 & (Rd1 != 0) & (Rd1 == Rt))) begin 
			ForwardB = 01;
			
		end
		else begin
			ForwardB = 00;
		end
	end

endmodule