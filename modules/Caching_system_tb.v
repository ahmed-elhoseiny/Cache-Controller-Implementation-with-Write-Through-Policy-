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

    $monitor("time=%t \t WordAddress=%h \t DataIn=%h \t stall=%b \t DataOut=%h",
    $time,WordAddress_tb,DataIn_tb,stall_tb,DataOut_tb);

    ///////////Reset//////////////////////////
    clk_tb      = 1'b1 ;
    reset_tb    = 1'b0;
  #(Clk_period*2)
    reset_tb    = 1'b1;
    //////////////////////////////////////////
    $readmemh ("Main_mem_data_h.txt",DUT.Main_Memory_U0.RAM);
    #(Clk_period*1)
    ///////////////////////// 4 write misses /////////////////////////
    /////////////// Write miss ////////////////////////
    WordAddress_tb  = 10'h0 ;
    DataIn_tb       = 32'h5 ;
    mem_read_tb     = 1'b0 ;
    mem_write_tb    = 1'b1 ;
  #(Clk_period*1)
  mem_write_tb    = 1'b0 ;
  #(Clk_period*2)
  $display("status %s",(DUT.Main_Memory_U0.RAM[10'h0] == 32'h5)?"Test case 1 succed":"Test case 1 failed") ;
    /////////////// Write miss ////////////////////////
    WordAddress_tb  = 10'h1 ;
    DataIn_tb       = 32'h15 ;
    mem_read_tb     = 1'b0 ;
    mem_write_tb    = 1'b1 ;
  #(Clk_period*1)
  mem_write_tb    = 1'b0 ;
  #(Clk_period*2)
  $display("status %s",(DUT.Main_Memory_U0.RAM[10'h1] == 32'h15)?"Test case 2 succed":"Test case 2 failed") ;
    /////////////// Write miss ////////////////////////
    WordAddress_tb  = 10'h2 ;
    DataIn_tb       = 32'h25 ;
    mem_read_tb     = 1'b0 ;
    mem_write_tb    = 1'b1 ;
  #(Clk_period*1)
  mem_write_tb    = 1'b0 ;
  #(Clk_period*2)
   $display("status %s",(DUT.Main_Memory_U0.RAM[10'h2] == 32'h25)?"Test case 3 succed":"Test case 3 failed") ;
    /////////////// Write miss ////////////////////////
    WordAddress_tb  = 10'h3 ;
    DataIn_tb       = 32'h35 ;
    mem_read_tb     = 1'b0 ;
    mem_write_tb    = 1'b1 ;
  #(Clk_period*1)
  mem_write_tb    = 1'b0 ;
  #(Clk_period*2)
  $display("status %s",(DUT.Main_Memory_U0.RAM[10'h3] == 32'h35)?"Test case 4 succed":"Test case 4 failed") ;
    /////////////// Write miss to the last block in memory ////////////////////////
    WordAddress_tb  = 10'h3ff ;
    DataIn_tb       = 32'h5c79 ;
    mem_read_tb     = 1'b0 ;
    mem_write_tb    = 1'b1 ;
  #(Clk_period*1)
  mem_write_tb    = 1'b0 ;
  #(Clk_period*2)
  $display("status %s",(DUT.Main_Memory_U0.RAM[10'h3ff] == 32'h5c79)?"Test case 5 succed":"Test case 5 failed") ;
  /////////////////////////////////////////////////////////////////////
  //////////////// read miss to the last block in memory ///////////////////////////////
    WordAddress_tb  = 10'h3ff ;
    mem_read_tb     = 1'b1 ;
    mem_write_tb    = 1'b0 ;
  #(Clk_period*1)
    mem_read_tb     = 1'b0 ;
  #(Clk_period*8)
  $display("status %s",(DataOut_tb == 32'h5c79)?"Test case 6 succed":"Test case 6 failed") ;
  //////////////// read miss ///////////////////////////////
    WordAddress_tb  = 10'h1 ;
    mem_read_tb     = 1'b1 ;
    mem_write_tb    = 1'b0 ;
  #(Clk_period*1)
    mem_read_tb     = 1'b0 ;
  #(Clk_period*8)
  $display("status %s",(DataOut_tb == 32'h15)?"Test case 7 succed":"Test case 7 failed") ;
    ///////////////////////// 4 Read hits /////////////////////////
    ////////////// read Hit /////////////////////////////
    WordAddress_tb  = 10'h0 ;
    mem_read_tb     = 1'b1 ;
    mem_write_tb    = 1'b0 ;
  #(Clk_period*1)
    mem_read_tb     = 1'b0 ;
  #(Clk_period*2)
  $display("status %s",(DataOut_tb == 32'h5)?"Test case 8 succed":"Test case 8 failed") ;
    ////////////// read Hit /////////////////////////////
    WordAddress_tb  = 10'h1 ;
    mem_read_tb     = 1'b1 ;
    mem_write_tb    = 1'b0 ;
  #(Clk_period*1)
    mem_read_tb     = 1'b0 ;
  #(Clk_period*2)
  $display("status %s",(DataOut_tb == 32'h15)?"Test case 9 succed":"Test case 9 failed") ;
    ////////////// read Hit /////////////////////////////
    WordAddress_tb  = 10'h2 ;
    mem_read_tb     = 1'b1 ;
    mem_write_tb    = 1'b0 ;
  #(Clk_period*1)
    mem_read_tb     = 1'b0 ;
  #(Clk_period*2)
  $display("status %s",(DataOut_tb == 32'h25)?"Test case 10 succed":"Test case 10 failed") ;
    ////////////// read Hit /////////////////////////////
    WordAddress_tb  = 10'h3 ;
    mem_read_tb     = 1'b1 ;
    mem_write_tb    = 1'b0 ;
  #(Clk_period*1)
    mem_read_tb     = 1'b0 ;
  #(Clk_period*2)
  $display("status %s",(DataOut_tb == 32'h35)?"Test case 11 succed":"Test case 11 failed") ;
    ///////////////////////// 4 Read misses /////////////////////////
    //////////////// read miss ///////////////////////////////
    WordAddress_tb  = 10'h20 ;
    mem_read_tb     = 1'b1 ;
    mem_write_tb    = 1'b0 ;
  #(Clk_period*1)
    mem_read_tb     = 1'b0 ;
  #(Clk_period*8)
  $display("status %s",(DataOut_tb == 32'h20)?"Test case 12 succed":"Test case 12 failed") ;
    //////////////// read miss ///////////////////////////////
    WordAddress_tb  = 10'h40 ;
    mem_read_tb     = 1'b1 ;
    mem_write_tb    = 1'b0 ;
  #(Clk_period*1)
    mem_read_tb     = 1'b0 ;
  #(Clk_period*8)
  $display("status %s",(DataOut_tb == 32'h40)?"Test case 13 succed":"Test case 13 failed") ;
    //////////////// read miss ///////////////////////////////
    WordAddress_tb  = 10'h60 ;
    mem_read_tb     = 1'b1 ;
    mem_write_tb    = 1'b0 ;
  #(Clk_period*1)
    mem_read_tb     = 1'b0 ;
  #(Clk_period*8)
  $display("status %s",(DataOut_tb == 32'h60)?"Test case 14 succed":"Test case 14 failed") ;
    //////////////// read miss ///////////////////////////////
    WordAddress_tb  = 10'ha ;
    mem_read_tb     = 1'b1 ;
    mem_write_tb    = 1'b0 ;
  #(Clk_period*1)
    mem_read_tb     = 1'b0 ;
  #(Clk_period*8)
  $display("status %s",(DataOut_tb == 32'ha)?"Test case 15 succed":"Test case 15 failed") ;
    ///////////////////////// 4 write Hits /////////////////////////
    /////////////// Write Hit ////////////////////////
    WordAddress_tb  = 10'h8 ;
    DataIn_tb       = 32'h11 ;
    mem_read_tb     = 1'b0 ;
    mem_write_tb    = 1'b1 ;
  #(Clk_period*1)
  mem_write_tb    = 1'b0 ;
  #(Clk_period*2)
  $display("status %s",(DUT.Main_Memory_U0.RAM[10'h8] == 32'h11 && DUT.Cache.CACHE['d2][32-1:0]==32'h11)?"Test case 16 succed":"Test case 16 failed") ;
    /////////////// Write Hit ////////////////////////
    WordAddress_tb  = 10'h9 ;
    DataIn_tb       = 32'h22 ;
    mem_read_tb     = 1'b0 ;
    mem_write_tb    = 1'b1 ;
  #(Clk_period*1)
  mem_write_tb    = 1'b0 ;
  #(Clk_period*2)
  $display("status %s",(DUT.Main_Memory_U0.RAM[10'h9] == 32'h22 && DUT.Cache.CACHE['d2][32*2-1:32]==32'h22)?"Test case 17 succed":"Test case 17 failed") ;
    /////////////// Write Hit ////////////////////////
    WordAddress_tb  = 10'ha ;
    DataIn_tb       = 32'h33 ;
    mem_read_tb     = 1'b0 ;
    mem_write_tb    = 1'b1 ;
  #(Clk_period*1)
  mem_write_tb    = 1'b0 ;
  #(Clk_period*2)
  $display("status %s",(DUT.Main_Memory_U0.RAM[10'ha] == 32'h33 && DUT.Cache.CACHE['d2][32*3-1:32*2]==32'h33)?"Test case 18 succed":"Test case 18 failed") ;
    /////////////// Write Hit ////////////////////////
    WordAddress_tb  = 10'hb ;
    DataIn_tb       = 32'h44 ;
    mem_read_tb     = 1'b0 ;
    mem_write_tb    = 1'b1 ;
  #(Clk_period*1)
  mem_write_tb    = 1'b0 ;
  #(Clk_period*2)
$display("status %s",(DUT.Main_Memory_U0.RAM[10'hb] == 32'h44 && DUT.Cache.CACHE['d2][32*4-1:32*3]==32'h44)?"Test case 19 succed":"Test case 19 failed") ;
  /////////////// Write Hit ////////////////////////
    WordAddress_tb  = 10'h60 ;
    DataIn_tb       = 32'h0 ;
    mem_read_tb     = 1'b0 ;
    mem_write_tb    = 1'b1 ;
  #(Clk_period*1)
  mem_write_tb    = 1'b0 ;
  #(Clk_period*2)
$display("status %s",(DUT.Main_Memory_U0.RAM[10'h60] == 32'h0 && DUT.Cache.CACHE[5'b11000][32-1:0]==32'h0)?"Test case 20 succed":"Test case 20 failed") ;
  ////////////////////////////////////////////////////
  $finish ;

    end
endmodule