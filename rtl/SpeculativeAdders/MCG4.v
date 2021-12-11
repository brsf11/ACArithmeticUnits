module MCG4(input wire[3:0] P,G,
            input wire      Cin,
            output wire     C);

    assign C = G[3] | (G[2] & P[3]) | (G[1] & P[3] & P[2]) | (G[0] & P[3] & P[2] & P[1]) | (Cin & P[3] & P[2] & P[1] & P[0]);

endmodule