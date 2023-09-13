module MUX_4_to_1 #(
parameter WIDTH  =32 ,
          sel_WIDTH =2 
) (
input        wire       [WIDTH-1:0]       In1,
input        wire       [WIDTH-1:0]       In2,
input        wire       [WIDTH-1:0]       In3,
input        wire       [WIDTH-1:0]       In4,
input        wire       [sel_WIDTH-1:0]   sel,

output       reg        [WIDTH-1:0]       out
);

assign out = (sel==2'b00) ? In1 : (sel==2'b01) ? In2 : (sel==2'b10) ? In3 : In4 ;

/*
always @(*) 
begin
    case (sel)
       2'b00: out = In1;
       2'b01: out = In2;
       2'b10: out = In3;
       2'b11: out = In4;
    endcase
end
*/
endmodule