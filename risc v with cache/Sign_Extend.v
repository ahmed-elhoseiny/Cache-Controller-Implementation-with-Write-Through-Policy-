module Sign_Extend #(parameter WIDTH = 32)
(
input    wire     [WIDTH-1:0]        Instr,  // to select imm locations from it 
input    wire     [1:0]              ImmSrc,
output   reg     [WIDTH-1:0]        ImmExt
);

always @(*) 
begin
    case (ImmSrc)
    2'b00: ImmExt = {{20{Instr[31]}}, Instr[31:20]} ;
    2'b01: ImmExt = {{20{Instr[31]}}, Instr[31:25], Instr[11:7]} ;
    2'b10: ImmExt = {{20{Instr[31]}}, Instr[7], Instr[30:25], Instr[11:8], 1'b0} ;
    2'b11: ImmExt = {{12{Instr[31]}}, Instr[19:12], Instr[20], Instr[30:21], 1'b0} ;
 endcase



    /*
    if (Imm[Imm_Size-1]) 
    begin
        SignImm = {{(WIDTH-Imm_Size){1'b1}},Imm};
    end else 
    begin
        SignImm = {{(WIDTH-Imm_Size){1'b0}},Imm};
    end
    */
end 
endmodule