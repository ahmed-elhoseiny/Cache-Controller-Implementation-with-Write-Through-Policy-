module RISC_V_TOP #(
    parameter  WIDTH = 32,
    parameter  DEPTH = 100
)  
(
    input       wire                   CLK,RST,
    //output      wire [WIDTH-1:0]       Result,
    output      wire         [15:0]    Test_Value

);

wire [WIDTH-1:0] S_PC, S_PCNext,S_PCPlus4, S_PCTarget;
wire [WIDTH-1:0] S_Instr;
wire [WIDTH-1:0] S_Result;
wire             S_RegWrite, S_Zero, S_ALUSrc, S_PCSrc, S_MemWrite,S_MemRead,S_stall;
wire [WIDTH-1:0] S_SrcA, S_SrcB ,S_ALUResult;
wire [WIDTH-1:0] S_WriteData;
wire [2:0] S_ALUControl;
wire [1:0] S_ImmSrc, S_ResultSrc;
wire [WIDTH-1:0] S_ImmExt, S_ReadData;



Instruction_Memory  #(
                     .WIDTH(WIDTH),
                     .DEPTH(DEPTH) 
 ) Instruction_Memory_U1 
 (
.A(S_PC),
.RD(S_Instr)
);


Register_File  #(
                .WIDTH(WIDTH), 
                .DEPTH(DEPTH), 
                .REG_ADDR(5)
                )  Register_File_U1
( 
.A1(S_Instr[19:15]),
.A2(S_Instr[24:20]),
.A3(S_Instr[11:7]),
.WD3(S_Result),
.WE3(S_RegWrite),
.CLK(CLK),
.RST(RST),

.RD1(S_SrcA),
.RD2(S_WriteData)
);



Control_Unit Control_Unit_U1
(
.Funct3(S_Instr[14:12]),
.Opcode(S_Instr[6:0]),
.Funct7_5(S_Instr[30]), 
.Zero(S_Zero),

.ResultSrc(S_ResultSrc), 
.ImmSrc(S_ImmSrc),
.ALUControl(S_ALUControl),
.PCSrc(S_PCSrc), 
.ALUSrc(S_ALUSrc), 
.MemWrite(S_MemWrite), 
.MemRead(S_MemRead),
.RegWrite(S_RegWrite)
);


Sign_Extend  #(.WIDTH(WIDTH)) Sign_Extend_U1
(
.Instr(S_Instr),  // to select imm locations from it 
.ImmSrc(S_ImmSrc),
.ImmExt(S_ImmExt)
);

MUX_2_to_1  #(.WIDTH(WIDTH)) MUX_2_to_1_SrcB_U1
(
.In1(S_WriteData),
.In2(S_ImmExt),
.sel(S_ALUSrc),

.out(S_SrcB)
);


ALU #(.WIDTH(WIDTH)) ALU_U1
(
.SrcA(S_SrcA),
.SrcB(S_SrcB),
.ALUControl(S_ALUControl),

.ALUResult(S_ALUResult),
.Zero(S_Zero)
);

/*
Data_Memory #(.WIDTH(WIDTH), .DEPTH(DEPTH)) Data_Memory_U1
(
.A(S_ALUResult),
.WD(S_WriteData),
.WE(S_MemWrite),
.CLK(CLK),
.RST(RST),
.Test_Value(Test_Value),
.RD(S_ReadData)
);
*/

Caching_system  Caching_system_U1 (
    .WordAddress(S_ALUResult[9:0]),
    .DataIn(S_WriteData),
    .mem_read(S_MemRead),
    .mem_write(S_MemWrite),
    .clk(CLK),
    .reset(RST),
    .stall(S_stall),
    .DataOut(S_ReadData)
);



Adder #(.WIDTH(WIDTH)) Adder_PCTarget_U1
(
.A(S_PC),
.B(S_ImmExt),

.C(S_PCTarget)
);


MUX_4_to_1 #(.WIDTH(WIDTH),.sel_WIDTH(2)) MUX_4_to_1_Result_U1
(
.In1(S_ALUResult),
.In2(S_ReadData),
.In3(S_PCPlus4),
.In4('b0),
.sel(S_ResultSrc),

.out(S_Result)
);

Program_Counter #(.WIDTH(WIDTH)) Program_Counter_U1
(
.CLK(CLK),
.RST(RST),
.PCNext(S_PCNext),
.stall(S_stall),
.PC(S_PC)
);

/////////////////////////////////////////////////////

MUX_2_to_1  #(.WIDTH(WIDTH)) MUX_2_to_1_PCNext_U1
(
.In1(S_PCPlus4),
.In2(S_PCTarget),
.sel(S_PCSrc),

.out(S_PCNext)
);


Adder #(.WIDTH(WIDTH)) Adder_PCPlus4_U1
(
.A(S_PC),
.B('d4),

.C(S_PCPlus4)
);


endmodule