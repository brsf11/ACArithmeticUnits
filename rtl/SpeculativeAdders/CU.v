module CU(input wire  P,G,Cin,
          output wire C);

    assign C = (Cin & P) | G;

endmodule