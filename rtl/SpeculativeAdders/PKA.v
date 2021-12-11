module PKA(input wire[7:0]  A,B,
           input wire       Cin,
           output wire[7:0] Sum,
           output wire      Cout);

    wire[7:0] P,G,C;

    //PGs

    PG PG0(
        .A (A[0]),
        .B (B[0]),
        .P (P[0]),
        .G (G[0])
    );

    PG PG1(
        .A (A[1]),
        .B (B[1]),
        .P (P[1]),
        .G (G[1])
    );

    PG PG2(
        .A (A[2]),
        .B (B[2]),
        .P (P[2]),
        .G (G[2])
    );

    PG PG3(
        .A (A[3]),
        .B (B[3]),
        .P (P[3]),
        .G (G[3])
    );

    PG PG4(
        .A (A[4]),
        .B (B[4]),
        .P (P[4]),
        .G (G[4])
    );

    PG PG5(
        .A (A[5]),
        .B (B[5]),
        .P (P[5]),
        .G (G[5])
    );

    PG PG6(
        .A (A[6]),
        .B (B[6]),
        .P (P[6]),
        .G (G[6])
    );

    PG PG7(
        .A (A[7]),
        .B (B[7]),
        .P (P[7]),
        .G (G[7])
    );

    //Sms

    Sm Sm0(
        .P   (P[0]),
        .C   (C[0]),
        .S (Sum[0])
    );

    Sm Sm1(
        .P   (P[1]),
        .C   (C[1]),
        .S (Sum[1])
    );

    Sm Sm2(
        .P   (P[2]),
        .C   (C[2]),
        .S (Sum[2])
    );

    Sm Sm3(
        .P   (P[3]),
        .C   (C[3]),
        .S (Sum[3])
    );

    Sm Sm4(
        .P   (P[4]),
        .C   (C[4]),
        .S (Sum[4])
    );

    Sm Sm5(
        .P   (P[5]),
        .C   (C[5]),
        .S (Sum[5])
    );

    Sm Sm6(
        .P   (P[6]),
        .C   (C[6]),
        .S (Sum[6])
    );

    Sm Sm7(
        .P   (P[7]),
        .C   (C[7]),
        .S (Sum[7])
    );

    //MCG4s

    MCG4 MCG40(
        .P   (P[3:0]),
        .G   (G[3:0]),
        .Cin (Cin),
        .C   (C[4])
    );

    MCG4 MCG41(
        .P   (P[4:1]),
        .G   (G[4:1]),
        .Cin (1'b0),
        .C   (C[5])
    );

    MCG4 MCG42(
        .P   (P[5:2]),
        .G   (G[5:2]),
        .Cin (1'b0),
        .C   (C[6])
    );

    MCG4 MCG43(
        .P   (P[6:3]),
        .G   (G[6:3]),
        .Cin (1'b0),
        .C   (C[7])
    );

    MCG4 MCG44(
        .P   (P[7:4]),
        .G   (G[7:4]),
        .Cin (1'b0),
        .C   (Cout)
    );

    //Rest carry logic

    assign C[0] = Cin;
    assign C[1] = G[0] | (Cin & P[0]);
    assign C[2] = G[1] | (G[0] & P[1]) | (Cin & P[1] & P[0]);
    assign C[3] = G[2] | (G[1] & P[2]) | (G[0] & P[2] & P[1]) | (Cin & P[2] & P[1] & P[0]);

    

endmodule