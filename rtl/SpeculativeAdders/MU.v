module MU(input wire Pia,Gia,Pib,Gib,
          output wire Po,Go);

    assign Po = Pia & Pib;
    assign Go = (Pia & Gib) | Gia;

endmodule