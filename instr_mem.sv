module Instr_mem(A,rst,RD);
	input [31:0] A;
	input rst;
	output [31:0] RD;


reg [31:0] mem [1023:0];

assign RD = (rst==0)? 32'h0000_0000: mem[A];
initial begin
	//mem[0] =32'hFFC4A303;
	//mem[1] =32'h00832383;
	//mem[2] = 32'hFFC4A303;
	//mem[3] = 32'h0062E233;
	mem[0]= 32'h00200293;
	mem[4]=32'h04000313;
	mem[8]=32'h00532423;
	mem[12]=32'h00832383;
end
endmodule 