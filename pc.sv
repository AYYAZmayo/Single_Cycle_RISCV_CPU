module P_C(PC_NEXT, PC, rst, clk);
input [31:0]PC_NEXT;
input rst,clk;
output reg [31:0]PC;

always @(posedge clk)begin
	if(~rst)
		PC <= 'b0;
	else
		PC <= PC_NEXT;
end

endmodule