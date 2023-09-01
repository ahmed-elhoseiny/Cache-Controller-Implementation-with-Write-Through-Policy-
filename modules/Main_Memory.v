module Main_Memory #(
    parameter WIDTH = 32,
              DEPTH = 1024
) (
    input wire                    clk,reset,        
    input wire [$log2(DEPTH)-1:0] address;
    input wire                    write_en,  
//    input wire                    read_en,    
    input wire [WIDTH-1:0]        write_data,

    output wire [WIDTH-1:0]       read_data 
);
    


endmodule