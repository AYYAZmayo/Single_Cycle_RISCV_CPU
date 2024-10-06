module reg_file(

input WE3, // write enable
input  clk,rst,
input [31:0]WD3, // data-in (write data)
input [4:0] A1,A2, // Address read
input [4:0] A3, // Address write;
output [31:0] RD1,RD2

);
reg [31:0] regfile[31:1];
always @(posedge clk)begin
		if (WE3)
			regfile[A3]<= WD3;
end
assign RD1 = (~rst)? 32'd0 :(A1==0) ? 'b0: regfile[A1];
assign RD2 = (~rst)? 32'd0 :(A2==0) ? 'b0: regfile[A2];

initial
	begin
		regfile[9]=32'h00000020;
		//regfile[6]=32'h00000040;
	end


endmodule