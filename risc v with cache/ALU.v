module ALU #(parameter WIDTH = 32)
(
input	wire	[WIDTH-1:0]		SrcA,
input	wire	[WIDTH-1:0]		SrcB,
input	wire	[2:0]			ALUControl,

output	reg		[WIDTH-1:0]		ALUResult,
output	wire					Zero

);

always @(*)
begin
	case (ALUControl)
    3'b000: ALUResult = SrcA + SrcB;
	3'b001: ALUResult = SrcA - SrcB;
	3'b101: ALUResult = (SrcA < SrcB) ? 'b1 : 'b0 ;
	3'b011: ALUResult = SrcA | SrcB;
	3'b010: ALUResult = SrcA & SrcB;
	default : ALUResult = 'b0 ;
	endcase
end

assign Zero = ( ALUResult == 'b0 ) ;

endmodule
