`include "pc.sv"
`include "mux2x1.sv"
`include "PC_Adder.sv"
`include "ALU_Decoder.sv"
`include "Main_Decoder.sv"
`include "Control_unit_top.sv"
`include "alu.sv"
`include "data_mem.sv"
`include "instr_mem.sv"
`include "Reg_file.sv"
`include "mux4x1.sv"
`include "sign_extend.sv"
module single_cycle_top(clk,rst);
	input clk,rst;
	wire [31:0] PC, PCPlus4 ,RD_instr, RD1_top,RD2_top, Imm_Ext_top,ALU_Result,ReadData,SrcB,Result,PCTarget,PCNext ;
	wire RegWrite_top, MemWrite,ALUSrc;
	wire [1:0]ImmSrc,ResultSrc;
	wire [2:0] ALUControl_top;
	
	
	P_C pc(
			.PC_NEXT(PCNext), 
			.PC(PC), 
			.rst(rst), 
			.clk(clk)
			);
			
	Mux2x1 mux_PC_select(
						.a(PCPlus4), // S0
						.b(PCTarget), // S1
						.s(PCSrc),
						.y(PCNext)
						);
	PC_Adder pc_plus4(
					.a(PC),
					.b(32'd4),
					.c(PCPlus4)
					);
	PC_Adder branch_offset_adder(
					.a(PC),
					.b(Imm_Ext_top),
					.c(PCTarget)
					);
	
	Instr_mem IM(
				.A(PC),
				.rst(rst),
				.RD(RD_instr)
				);
	
	reg_file RF(
			.WE3(RegWrite_top), // write enable
			.clk(clk),
			.rst(rst),
			.WD3(Result), //(write back data)
			.A1(RD_instr[19:15]), //RS1
			.A2(RD_instr[24:20]), // RS2
			.A3(RD_instr[11:7]), // RD;
			.RD1(RD1_top),
			.RD2(RD2_top)
			);
			
	sign_extend  signextnd(
							.In(RD_instr),
							.ImmSrc(ImmSrc),
							.Imm_Ext(Imm_Ext_top)
							);
				
				
	Mux2x1 mux_regfile_2_alu(
						.a(RD2_top),
						.b(Imm_Ext_top),
						.s(ALUSrc),
						.y(SrcB)
						);
	
	alu ALU(
		.A(RD1_top), 
		.B(SrcB), 
		.ALUControl(ALUControl_top), 
		.Result(ALU_Result) ,
		.Negative(), 
		.Zero(Zero), 
		.Carry(), 
		.OverFlow()
		);
		
Control_Unit_Top cntrl_unit_top(
							.Op(RD_instr[6:0]),
							.Zero(Zero),							
							.PCSrc(PCSrc), 
							.ResultSrc(ResultSrc), 
							.MemWrite(MemWrite), 
							.ALUSrc(ALUSrc), 
							.ImmSrc(ImmSrc), 
							.RegWrite(RegWrite_top),
							.funct3(RD_instr[14:12]),
							.funct7(RD_instr[31:25]),
							.ALUControl(ALUControl_top)
							);
data_mem DATA_MEM (
				.A(ALU_Result),
				.WD(RD2_top),
				.clk(clk),
				.WE(MemWrite),
				.rst(rst),
				.RD(ReadData)
				);
				
	Mux4x1 mux_data_mem_2_regfile(
						.a(ALU_Result),
						.b(ReadData),
						.c(PCPlus4),
						.s(ResultSrc),
						.y(Result)
						);
		
endmodule