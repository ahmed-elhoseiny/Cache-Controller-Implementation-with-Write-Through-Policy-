`timescale  1ns/1ps
module Caching_system_tb ();

    parameter   Clk_period      = 20 ;
    parameter   address_width   = 10 ;
    parameter   WIDTH           = 32 ;

    //////////////////////////////////////////////////////////
    ////////////////// Inputs and outputs ///////////////////
    ////////////////////////////////////////////////////////
    reg     [address_width-1:0]     WordAddress_tb ;
    reg     [WIDTH-1:0]             DataIn_tb ;
    reg                             mem_read_tb,mem_write_tb,clk_tb,reset_tb ;
    wire                            stall_tb ;
    wire    [WIDTH-1:0]             DataOut_tb ;

    /////////////////////////////////////////////////////////
    ///////////////// DUT instantiation ////////////////////
    ///////////////////////////////////////////////////////
    Caching_system DUT (
    .WordAddress(WordAddress_tb),
    .DataIn(DataIn_tb),
    .mem_read(mem_read_tb),
    .mem_write(mem_write_tb),
    .clk(clk_tb),
    .reset(reset_tb),
    .stall(stall_tb),
    .DataOut(DataOut_tb)
);

    //////////////////////////////////////////////////
    ////////////// Generate Clock ///////////////////
    //////////////////////////////////////////////// 
always #(Clk_period/2) clk_tb = ~clk_tb ;

    initial 
    begin

    ///////////Use the monitor task to display///////////////

    $monitor("time=%t \t mem_read=%b \t mem_write=%b \t WordAddress=%b \t DataIn=%d \t stall=%b \t DataOut=%d", 
    $time,mem_read_tb,mem_write_tb,WordAddress_tb,DataIn_tb,stall_tb,DataOut_tb);

    ///////////Reset//////////////////////////
    clk_tb      = 1'b1 ;
    reset_tb    = 1'b0;
  #(Clk_period*10)
    reset_tb    = 1'b1;
    //////////////////////////////////////////
    WordAddress_tb  = 10'b0000000001 ;
    DataIn_tb       = 32'd5 ;
    mem_read_tb     = 1'b0 ;
    mem_write_tb    = 1'b1 ;
  #(Clk_period*1)
  mem_write_tb    = 1'b0 ;
  #(Clk_period*2)
    WordAddress_tb  = 10'b0000000001 ;
    // DataIn_tb       = 32'd5 ;
    mem_read_tb     = 1'b1 ;
    mem_write_tb    = 1'b0 ;
  #(Clk_period*1)
    mem_read_tb     = 1'b0 ;
  #(Clk_period*8)
  //   WordAddress_tb  = 10'b0000000100 ;
  //   // DataIn_tb       = 32'd5 ;
  //   mem_read_tb     = 1'b1 ;
  //   mem_write_tb    = 1'b0 ;
  // #(Clk_period*7)
  //   WordAddress_tb  = 10'b0000000011 ;
  //   DataIn_tb       = 32'd10 ;
  //   mem_read_tb     = 1'b0 ;
  //   mem_write_tb    = 1'b1 ;
  // #(Clk_period*3)
  $finish ;

    end
endmodule