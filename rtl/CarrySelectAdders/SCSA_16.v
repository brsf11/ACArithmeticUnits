module SCSA_16 #(
        parameter subwididx = 2,
        parameter widmul    = 4
    ) 
    (
        input wire[widmul*(2**subwididx)-1:0]  A,B,
        input wire                             Cin,
        output wire[widmul*(2**subwididx)-1:0] Sum,
        output wire                            Cout
    );

    wire[widmul-1:0]                   SegCin;
    wire[widmul-1:0][2**subwididx-1:0] SegSum0,SegSum1;
    wire[widmul-1:0]                   Cout0,Cout1;

    assign SegCin[0] = Cin;

    genvar i;

    generate
        for(i=0;i<widmul;i=i+1)begin
            KSA #(
                .wididx(subwididx)
            ) KSA0
            (
                .A      (A[(i+1)*(2**subwididx)-1:i*(2**subwididx)]),
                .B      (B[(i+1)*(2**subwididx)-1:i*(2**subwididx)]),
                .Cin    (1'b0),
                .Sum    (SegSum0[i][2**subwididx-1:0]),
                .Cout   (Cout0[i])
            );

            KSA #(
                .wididx(subwididx)
            ) KSA1
            (
                .A      (A[(i+1)*(2**subwididx)-1:i*(2**subwididx)]),
                .B      (B[(i+1)*(2**subwididx)-1:i*(2**subwididx)]),
                .Cin    (1'b1),
                .Sum    (SegSum1[i][2**subwididx-1:0]),
                .Cout   (Cout1[i])
            );
        end
    endgenerate

    generate
        for(i=1;i<widmul;i=i+1)begin
            assign SegCin[i] = Cout0[i-1];
        end
    endgenerate

    generate
        for(i=0;i<widmul;i=i+1)begin
            assign Sum[(i+1)*(2**subwididx)-1:i*(2**subwididx)] = SegCin[i] ? SegSum1[i][2**subwididx-1:0] : SegSum0[i][2**subwididx-1:0];
        end
    endgenerate

    assign Cout = SegCin[widmul-1] ? Cout1[widmul-1] : Cout0[widmul-1];

endmodule