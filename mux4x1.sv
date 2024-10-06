module Mux4x1 (a,b,c,s,y);
input [31:0]a,b,c;
input [1:0]s;
output [31:0]y;

assign y = (s==2'b10)? c : (s==2'b01)? b : a;

endmodule