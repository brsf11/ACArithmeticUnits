module Adder #(
               parameter axa = 3,
               parameter fa  = 5
              )
              (
               input wire                  Cin,
               input wire[axa + fa - 1:0]  A,B,
               output wire                 Cout,
               output wire[axa + fa - 1:0] Sum
              );

    wire[axa + fa - 1:0] temp;

    genvar i;
    AXA3 AXA0(
        .A    (A[0]),
        .B    (B[0]),
        .Cin  (Cin),
        .Sum  (Sum[0]),
        .Cout (temp[0])
    );

    generate

        for(i=1;i<axa;i=i+1)begin
            AXA3 AXA1(
                .A    (A[i]),
                .B    (B[i]),
                .Cin  (temp[i-1]),
                .Sum  (Sum[i]),
                .Cout (temp[i])
            );
        end
        
        for(i=axa;i<axa+fa;i=i+1)begin
            FA FA(
                .A    (A[i]),
                .B    (B[i]),
                .Cin  (temp[i-1]),
                .Sum  (Sum[i]),
                .Cout (temp[i])
            );
        end
    endgenerate

    assign Cout = temp[axa + fa - 1];

endmodule
