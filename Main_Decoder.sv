module Main_Decoder(Op, Branch, ResultSrc, MemWrite, ALUSrc, ImmSrc, RegWrite, ALUOp, Jump);

input [6:0]Op;

output Branch, MemWrite, ALUSrc,RegWrite,Jump;
output [1:0] ALUOp,ImmSrc, ResultSrc;




assign Branch = (Op == 7'b1100011)? 1'b1 :1'b0;
//assign PCSrc = Zero & Branch;


assign RegWrite =  (Op == 7'b0000011 | Op == 7'b0110011 | Op == 7'b0010011 | Op == 7'b1101111)? 1'b1 :1'b0; //LW or R-type or addi
assign ALUSrc   =  (Op == 7'b0000011 | Op == 7'b0100011 | Op == 7'b0010011)? 1'b1 :1'b0; //LW or SW or or addi
assign MemWrite =  (Op == 7'b0100011)? 1'b1 :1'b0; //SW
assign ResultSrc=  (Op == 7'b0000011 )? 2'b01 : (Op == 7'b1101111 )? 2'b10:2'b00; //LW or J

assign ALUOp  =  (Op == 7'b0110011 | Op == 7'b0010011)? 2'b10 : (Op == 7'b1100011)? 2'b01 : 2'b00; //R-type or addi
assign ImmSrc =  (Op == 7'b1100011)? 2'b10 : (Op == 7'b0100011)? 2'b01 : (Op == 7'b1101111)? 2'b11 : 2'b00;// SW or beq or J
assign Jump   = (Op == 7'b1101111)? 1'b1 : 1'b0;
endmodule