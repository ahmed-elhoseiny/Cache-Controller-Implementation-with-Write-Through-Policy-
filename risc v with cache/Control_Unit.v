module Control_Unit (
input wire [2:0] Funct3,
input wire [6:0] Opcode,
input wire       Funct7_5, Zero,


output wire [1:0] ResultSrc, ImmSrc,
output wire [2:0] ALUControl,
output wire       PCSrc, ALUSrc, MemWrite, MemRead, RegWrite

);

wire [1:0] S_ALUOp;
wire       S_Branch, S_Jump;

ALU_Decoder U1 (
.Funct3(Funct3),
.Funct7_5(Funct7_5),
.Op_5(Opcode[5]),
.ALUOp(S_ALUOp),
    
.ALUControl(ALUControl)
);

Main_Decoder U2 (
.Opcode(Opcode),

.Branch(S_Branch),
.Jump(S_Jump), 
.MemWrite(MemWrite), 
.MemRead(MemRead),
.ALUSrc(ALUSrc),
.RegWrite(RegWrite),
.ResultSrc(ResultSrc), 
.ImmSrc(ImmSrc), 
.ALUOp(S_ALUOp)
);

assign PCSrc = (Zero & S_Branch) | S_Jump;


endmodule