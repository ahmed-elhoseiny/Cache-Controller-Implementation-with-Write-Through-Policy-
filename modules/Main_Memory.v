module Main_Memory #(
    parameter WIDTH = 32,
              DEPTH = 1024
) (
    input wire                    clk,reset,        
    input wire [$log2(DEPTH)-1:0] address;
    input wire                    write_en,  
//    input wire                    read_en,    
    input wire [WIDTH-1:0]        write_data,

    output wire                   ready, 
    output wire [WIDTH-1:0]       read_data 
);
    
reg		[WIDTH-1:0] 	RAM		[0:DEPTH-1] ;
wire    [3-1:0]        count;

integer k ;
always @(posedge clk or negedge reset) 
begin
    if (!reset) 
    begin
        for ( k=0 ; k<=(DEPTH-1) ; k=k+1) 
        begin
            RAM[k] <= WIDTH'b0;
        end
        count <= 3'b0;
    end else if ((write_en || read_en)  && !(count == 3'b4;)) 
    begin
        count <=  count + 1'b1;
    end else if ((write_en ) && (count == 3'b4)) 
    begin
        RAM[address] <= write_data;
        count <= 3'b0;
    end else if ((read_en ) && (count == 3'b4)) 
    begin
        read_data <= RAM[address];
        count <= 3'b0;
    end
end

assign ready = ((count == 3'b4)) ? 1'b1 : 1'b0;
endmodule