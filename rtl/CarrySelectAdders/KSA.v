module KSA #(parameter wididx = 3) (input wire[2**wididx-1:0]  A,B,
                                    input wire                 Cin,
                                    output wire[2**wididx-1:0] Sum,
                                    output wire                Cout);

    wire[wididx:0][2**wididx-1:0] Q,PC;
    wire[2**wididx-1:0] tempq;

    genvar i,j;
    generate
        for(i=0;i<2**wididx;i=i+1)begin
            PG PG0(
                .A    (A[i]),
                .B    (B[i]),
                .P    (PC[0][i]),
                .G    (tempq[i])
            );
        end
    endgenerate

    assign Q[0][2**wididx-1:0] = {tempq[2**wididx-1:1],(tempq[0] | (PC[0][0] & Cin))};

    //P Tree

    assign PC[1][2**wididx-1:0] = PC[0][2**wididx-1:0];

    generate
        for(i=2;i<=wididx;i=i+1)begin
            for(j=0;j<2**(i-2);j=j+1)begin
                assign PC[i][j] = PC[i-1][j];
            end
            for(j=2**(i-2);j<2**wididx;j=j+1)begin
                assign PC[i][j] = PC[i-1][j] & PC[i-1][j-(2**(i-2))];
            end
        end
    endgenerate

    //Q Tree

    generate
        for(i=1;i<=wididx;i=i+1)begin
            for(j=0;j<2**(i-1);j=j+1)begin
                assign Q[i][j] = Q[i-1][j];
            end
            for(j=2**(i-1);j<2**wididx;j=j+1)begin
                assign Q[i][j] = Q[i-1][j] | (PC[i][j] & Q[i-1][j-(2**(i-1))]);
            end
        end
    endgenerate

    //Sum Gen

    assign Sum[2**wididx-1:0] = {Q[wididx][2**wididx-2:0] ^ PC[0][2**wididx-1:1] , Cin ^ PC[0][0]};
    assign Cout = Q[wididx][2**wididx-1];

endmodule