module Cache_array #(
    parameter WIDTH = 32,
              Size_Byte = 512,
              Block_Size_Byte = 16,
              DEPTH_Block = Size_Byte/Block_Size_Byte,
              words_in_ablock = Block_Size_Byte*8/WIDTH
) (
    input wire [WIDTH-1:0]                   write_data,
    input wire [$clog2(DEPTH_Block)-1:0]     index,  // index of blocks 
    input wire [$clog2(words_in_ablock)-1:0] offset,

    output reg []
);
    
endmodule