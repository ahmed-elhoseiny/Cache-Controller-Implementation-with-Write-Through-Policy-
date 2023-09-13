module ALU_Decoder (
input   wire     [2:0]              Funct3,
input   wire                        Funct7_5,
input   wire                        Op_5,
input   wire     [1:0]              ALUOp,

output  reg      [2:0]              ALUControl
);
    
always @(*) 
begin
    case (ALUOp)
    2'b00: ALUControl = 3'b000;
	2'b01: ALUControl = 3'b001;
	2'b10: case (Funct3)
            3'b000: case ({Op_5, Funct7_5} )
                    2'b11: ALUControl = 3'b001;
                    default: ALUControl = 3'b000;
                    endcase
            3'b010: ALUControl = 3'b101;
            3'b110: ALUControl = 3'b011;
            3'b111: ALUControl = 3'b010;
            default: ALUControl = 3'b000;
           endcase
	default : ALUControl = 3'b000;
	endcase

end
endmodule