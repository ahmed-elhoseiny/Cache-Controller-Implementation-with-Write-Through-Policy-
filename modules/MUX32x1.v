module MUX32x1 #(
    parameter   line_width  = 3, // Width of each input line
    parameter   WIDTH       = 32 // Width of MUX
) (
    input   wire    [(line_width*WIDTH)-1:0]    data_in,
    input   wire    [$clog2(WIDTH)-1:0]         select,
    output  reg     [(line_width-1):0]          out
);

  always @ (*) begin
    case (select)
      0: out = data_in[(line_width-1):0];
      1: out = data_in[(2*line_width)-1:line_width];
      2: out = data_in[(3*line_width)-1:(2*line_width)];
      3: out = data_in[(4*line_width)-1:(3*line_width)];
      4: out = data_in[(5*line_width)-1:(4*line_width)];
      5: out = data_in[(6*line_width)-1:(5*line_width)];
      6: out = data_in[(7*line_width)-1:(6*line_width)];
      7: out = data_in[(8*line_width)-1:(7*line_width)];
      8: out = data_in[(9*line_width)-1:(8*line_width)];
      9: out = data_in[(10*line_width)-1:(9*line_width)];
      10: out = data_in[(11*line_width)-1:(10*line_width)];
      11: out = data_in[(12*line_width)-1:(11*line_width)];
      12: out = data_in[(13*line_width)-1:(12*line_width)];
      13: out = data_in[(14*line_width)-1:(13*line_width)];
      14: out = data_in[(15*line_width)-1:(14*line_width)];
      15: out = data_in[(16*line_width)-1:(15*line_width)];
      16: out = data_in[(17*line_width)-1:(16*line_width)];
      17: out = data_in[(18*line_width)-1:(17*line_width)];
      18: out = data_in[(19*line_width)-1:(18*line_width)];
      19: out = data_in[(20*line_width)-1:(19*line_width)];
      20: out = data_in[(21*line_width)-1:(20*line_width)];
      21: out = data_in[(22*line_width)-1:(21*line_width)];
      22: out = data_in[(23*line_width)-1:(22*line_width)];
      23: out = data_in[(24*line_width)-1:(23*line_width)];
      24: out = data_in[(25*line_width)-1:(24*line_width)];
      25: out = data_in[(26*line_width)-1:(25*line_width)];
      26: out = data_in[(27*line_width)-1:(26*line_width)];
      27: out = data_in[(28*line_width)-1:(27*line_width)];
      28: out = data_in[(29*line_width)-1:(28*line_width)];
      29: out = data_in[(30*line_width)-1:(29*line_width)];
      30: out = data_in[(31*line_width)-1:(30*line_width)];
      31: out = data_in[(32*line_width)-1:(31*line_width)];
      default: out = 'bx; // Default case for invalid select values
    endcase
  end

endmodule