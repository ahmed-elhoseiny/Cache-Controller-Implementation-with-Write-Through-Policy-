module Main_Decoder (
input   wire    [6:0]    Opcode,

output  reg              Branch,Jump, MemWrite, MemRead, ALUSrc ,RegWrite,
output  reg     [1:0]    ResultSrc, ImmSrc, ALUOp
);

always @(*) 
begin
    case (Opcode)
    7'b0000011:     //lw 
    begin
        RegWrite = 1'b1;
        ImmSrc = 2'b00;
        ALUSrc = 1'b1;
        MemWrite = 1'b0;
        MemRead = 1'b1;
        ResultSrc = 2'b01;
        Branch = 1'b0;
        ALUOp = 2'b00;
        Jump = 1'b0;
    end

    7'b0100011:     //sw 
    begin
        RegWrite = 1'b0;
        ImmSrc = 2'b01;
        ALUSrc = 1'b1;
        MemWrite = 1'b1;
        MemRead = 1'b0;
        ResultSrc = 2'bXX;
        Branch = 1'b0;
        ALUOp = 2'b00;
        Jump = 1'b0;
    end

    7'b0110011:     //R-type  ADD, SUB, AND, OR,XOR ,SLT 
    begin
        RegWrite = 1'b1;
        ImmSrc = 2'bXX;
        ALUSrc = 1'b0;
        MemWrite = 1'b0;
        MemRead = 1'b0;
        ResultSrc = 2'b00;
        Branch = 1'b0;
        ALUOp = 2'b10;
        Jump = 1'b0;
    end

    7'b1100011:     //beq   
    begin
        RegWrite = 1'b0;
        ImmSrc = 2'b10;
        ALUSrc = 1'b0;
        MemWrite = 1'b0;
        MemRead = 1'b0;
        ResultSrc = 2'bXX;
        Branch = 1'b1;
        ALUOp = 2'b01;
        Jump = 1'b0;
    end

    7'b0010011:     //I-type ALU   andi, ori, slti
    begin
        RegWrite = 1'b1;
        ImmSrc = 2'b00;
        ALUSrc = 1'b1;
        MemWrite = 1'b0;
        MemRead = 1'b0;
        ResultSrc = 2'b00;
        Branch = 1'b0;
        ALUOp = 2'b10;
        Jump = 1'b0;
    end
        
    7'b1101111:     //jal 
    begin
        RegWrite = 1'b1;
        ImmSrc = 2'b11;
        ALUSrc = 1'bX;
        MemWrite = 1'b0;
        MemRead = 1'b0;
        ResultSrc = 2'b10;
        Branch = 1'b0;
        ALUOp = 2'bXX;
        Jump = 1'b1;
    end

    default:           //default
    begin
        RegWrite = 1'b0;
        ImmSrc = 2'b00;
        ALUSrc = 1'b0;
        MemWrite = 1'b0;
        MemRead = 1'b0;
        ResultSrc = 2'b00;
        Branch = 1'b0;
        ALUOp = 2'b00;
        Jump = 1'b0;
    end
endcase
end

endmodule