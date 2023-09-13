`timescale 1ns/1ps

module RICS_V_tb ();

// DUT Signals
reg            CLK_tb ;
reg            RST_tb ;
wire  [15:0]   Test_Value_tb ;

  
// parameters
parameter  CLK_PERIOD = 20 ; 
    
initial 
begin
  $dumpfile("RICS_V.vcd");
  $dumpvars ;  
  //initial values
  CLK_tb = 1'b0;

  // initial reset
  RST_tb = 1'b1;
  #(CLK_PERIOD);
  RST_tb = 1'b0;
  #(CLK_PERIOD*0.5);
  RST_tb = 1'b1;
  #(CLK_PERIOD*0.5);
  #(CLK_PERIOD*0.5);

  #(300*CLK_PERIOD)  $stop;
end
  
// Clock Generator with 100 KHz (10 us)
  always  #(CLK_PERIOD/2) CLK_tb = ~ CLK_tb;  

// instantiate Design Unit
  RISC_V_TOP DUT (
.CLK(CLK_tb), 
.RST(RST_tb),

.Test_Value(Test_Value_tb)
);

endmodule