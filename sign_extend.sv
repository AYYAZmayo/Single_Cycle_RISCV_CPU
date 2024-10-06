module sign_extend(In,Imm_Ext,ImmSrc);
	input [31:0]In;
	input [1:0]ImmSrc;
	output [31:0]Imm_Ext;

assign Imm_Ext = (ImmSrc==2'b01)? ({{20{In[31]}},In[31:25],In[11:7]}): //S-type  12-bit signed immediate // sw
					//               31:13          11       [10:5]   [4:1]     0
				 (ImmSrc==2'b10)? ({{20{In[31]}}, In[7], In[30:25], In[11:8], 1'b0}): // B-type 13-bit signed immediate beq, bne,  blt,  bge,   bltu, bgeu
				 
				 (ImmSrc==2'b11)? ({{12{In[31]}}, In[19:12], In[20], In[30:21], 1'b0}): // J-type 21-bit signed immediate // jal
				 
				 ({{20{In[31]}},In[31:20]});// I-type 12-bit signed immediate // lw,  addi, slti, sltiu, xori, ori,  andi, jalr


endmodule 