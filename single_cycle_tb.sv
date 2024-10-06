module single_cycle_tb();
reg clk=0,rst;


single_cycle_top riscv1(.clk(clk),.rst(rst));

initial begin
	$dumpfile("dump.vcd");
	$dumpvars(0);
end

always  #50 clk=~clk;
		
	initial begin
		rst=1'b0;
		#100;
		
		rst=1'b1;
		#500;
		$finish;
	end
endmodule