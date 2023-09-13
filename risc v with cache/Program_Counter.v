module Program_Counter #(parameter WIDTH = 32 ) (
input   wire                    CLK ,
input   wire                    RST ,stall,
input	  wire	  [WIDTH-1:0]		  PCNext,
output  reg     [WIDTH-1:0]		  PC
);



always @(posedge CLK or negedge RST) 
begin
  if (!RST) 
  begin
    PC <= 'b0;
  end else if(!stall == 1'b1) 
  begin
    PC <= PCNext;
  end else if(!stall == 1'b0)
  begin
    PC <= PC;
  end
end




endmodule