module ALU_Decoder (Op, ALUOp, funct3, funct7,ALUControl);
input [6:0]Op;
input [2:0]funct3;
input [6:0]funct7;
input [1:0] ALUOp;

output [2:0]ALUControl;
wire concate = {Op[5],funct7[5]};

assign ALUControl = (ALUOp == 2'b00)? 3'b000 :
					(ALUOp == 2'b01)? 3'b001 : 
					((ALUOp == 2'b10) & (funct3==3'b000) &(concate==2'b00 |concate==2'b01 | concate==2'b10))? 3'b00:
					((ALUOp == 2'b10) & (funct3==3'b000) &(concate==2'b11))? 3'b001 : 
					((ALUOp == 2'b10) & (funct3==3'b010)) ? 3'b101 :
					((ALUOp == 2'b10) & (funct3==3'b110)) ? 3'b011 :
					((ALUOp == 2'b10) & (funct3==3'b111)) ? 3'b010 : 3'b00;
endmodule