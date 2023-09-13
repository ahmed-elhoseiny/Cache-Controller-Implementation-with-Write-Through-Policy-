module Caching_system #(
    parameter   address_width       = 10,
    parameter   WIDTH               = 32,
    parameter   Data_block_width    = 128
) (
    input   wire    [address_width-1:0] WordAddress,
    input   wire    [WIDTH-1:0]         DataIn,
    input   wire                        mem_read,mem_write,clk,reset,
    output  wire                        stall,
    output  wire    [WIDTH-1:0]         DataOut
);

    /////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////// Internal wires ////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////
    wire                            ready,hit,main_read,main_write,refill,update ;
    wire    [Data_block_width-1:0]  Data_block ;

    ////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////// FSM ////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////////
FSM Caching_controller (
    .mem_read(mem_read),
    .mem_write(mem_write),
    .ready(ready),
    .clk(clk),
    .reset(reset),
    .hit(hit),
    .stall(stall),
    .main_read(main_read),
    .main_write(main_write),
    .refill(refill),
    .update(update)
);

    /////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////// Cache ////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////
Cache_array Cache(
    .clk(clk),
    .reset(reset),
    .write_data(DataIn),
    .write_ablock(Data_block),
    .index(WordAddress[6:2]),  // index of line 
    .tag(WordAddress[9:7]),
    .offset(WordAddress[1:0]),
    .refill(refill),
    .update(update),
    .hit(hit),
    .read_data(DataOut)
);

    ///////////////////////////////////////////////////////////////////////////////
    ///////////////////////////// Main memory /////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////////
    Main_Memory Main_Memory_U0(
    .clk(clk),
    .reset(reset),        
    .address(WordAddress),
    .write_en(main_write),  
    .read_en(main_read),    
    .write_data(DataIn),
    .ready(ready), 
    .read_data(Data_block) 
);
    
endmodule