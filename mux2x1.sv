module Mux2x1 (a,b,s,y);
input [31:0]a,b;
input s;
output [31:0]y;

assign y = s ? b:a;

endmodule