module alu(A, B, ALUControl, Result ,Negative, Zero, Carry, OverFlow);
parameter n=32;

input [n-1:0] A,B;
input [2:0] ALUControl;
output [n-1:0] Result;
output Negative,Zero,Carry,OverFlow;

wire [n-1:0] sum, AandB, AorB, slt;
wire cout,Zeroextnd;
wire [n-1:0]mux1;


assign mux1= ALUControl[0]? ~B: B;
assign {cout,sum} = A+mux1;
assign AandB = (A & B);
assign AorB = (A | B);


assign Carry = !ALUControl[1] & cout;
assign OverFlow = (sum[31] ^ A[31]) & !(ALUControl[0] ^ A[31] ^ B[31]) & !ALUControl[1];
assign Zeroextnd = OverFlow ^ sum[31];

assign slt = {30'b0, Zeroextnd};


assign Result= (ALUControl==3'b000 | ALUControl==3'b001)? sum:
				(ALUControl==3'b010) ? AandB :
				(ALUControl==3'b011) ? AorB  :
				(ALUControl==3'b101) ? slt	 : 32'b0;


assign Negative = Result[31];
assign Zero = &(~Result);

endmodule 