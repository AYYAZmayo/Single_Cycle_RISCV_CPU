module data_mem(
input [31:0] A,
input [31:0] WD,
input clk,WE,rst,
output [31:0] RD
);

reg [31:0] d_mem [1023:0];

always @(posedge clk)begin
		if(WE)
			d_mem[A] = WD;
end

assign RD = (~rst)?  32'd0 : d_mem[A];

initial begin
	d_mem[28]=32'h00000020;
end
endmodule