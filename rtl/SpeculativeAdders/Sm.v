module Sm(input wire P,C,
          output wire S);

    assign S = P^C;

endmodule