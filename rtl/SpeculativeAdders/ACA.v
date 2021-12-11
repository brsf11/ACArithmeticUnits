module ACA(input wire[7:0]  A,B,
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

    //Carry logic

    wire[6:0] P1,G1;
    wire[4:0] P2,G2;

    //Level 0

    MU MU00(
        .Pia  (P[1]),
        .Gia  (G[1]),
        .Pib  (P[0]),
        .Gib  (G[0]),
        .Po  (P1[0]),
        .Go  (G1[0])
    );

    MU MU01(
        .Pia  (P[2]),
        .Gia  (G[2]),
        .Pib  (P[1]),
        .Gib  (G[1]),
        .Po  (P1[1]),
        .Go  (G1[1])
    );

    MU MU02(
        .Pia  (P[3]),
        .Gia  (G[3]),
        .Pib  (P[2]),
        .Gib  (G[2]),
        .Po  (P1[2]),
        .Go  (G1[2])
    );

    MU MU03(
        .Pia  (P[4]),
        .Gia  (G[4]),
        .Pib  (P[3]),
        .Gib  (G[3]),
        .Po  (P1[3]),
        .Go  (G1[3])
    );

    MU MU04(
        .Pia  (P[5]),
        .Gia  (G[5]),
        .Pib  (P[4]),
        .Gib  (G[4]),
        .Po  (P1[4]),
        .Go  (G1[4])
    );

    MU MU05(
        .Pia  (P[6]),
        .Gia  (G[6]),
        .Pib  (P[5]),
        .Gib  (G[5]),
        .Po  (P1[5]),
        .Go  (G1[5])
    );

    MU MU06(
        .Pia  (P[7]),
        .Gia  (G[7]),
        .Pib  (P[6]),
        .Gib  (G[6]),
        .Po  (P1[6]),
        .Go  (G1[6])
    );

    //Level 1

    MU MU10(
        .Pia (P1[2]),
        .Gia (G1[2]),
        .Pib (P1[0]),
        .Gib (G1[0]),
        .Po  (P2[0]),
        .Go  (G2[0])
    );

    MU MU11(
        .Pia (P1[3]),
        .Gia (G1[3]),
        .Pib (P1[1]),
        .Gib (G1[1]),
        .Po  (P2[1]),
        .Go  (G2[1])
    );

    MU MU12(
        .Pia (P1[4]),
        .Gia (G1[4]),
        .Pib (P1[2]),
        .Gib (G1[2]),
        .Po  (P2[2]),
        .Go  (G2[2])
    );

    MU MU13(
        .Pia (P1[5]),
        .Gia (G1[5]),
        .Pib (P1[3]),
        .Gib (G1[3]),
        .Po  (P2[3]),
        .Go  (G2[3])
    );

    MU MU14(
        .Pia (P1[6]),
        .Gia (G1[6]),
        .Pib (P1[4]),
        .Gib (G1[4]),
        .Po  (P2[4]),
        .Go  (G2[4])
    );

    //Carry compute

    assign C[0] = Cin;
    assign C[1] = G[0] | Cin & P[0];
    
    CU CU2(
        .P   (P1[0]),
        .G   (G1[0]),
        .Cin (Cin),
        .C   (C[2])
    );

    wire P3,G3;

    MU MU3(
        .Pia (P1[1]),
        .Gia (G1[1]),
        .Pib (P[0]),
        .Gib (G[0]),
        .Po  (P3),
        .Go  (G3)
    );

    CU CU3(
        .P   (P3),
        .G   (G3),
        .Cin (Cin),
        .C   (C[3])
    );

    CU CU4(
        .P   (P2[0]),
        .G   (G2[0]),
        .Cin (Cin),
        .C   (C[4])
    );

    //CUs

    CU CU5(
        .P   (P2[1]),
        .G   (G2[1]),
        .Cin (1'b0),
        .C   (C[5])
    );

    CU CU6(
        .P   (P2[2]),
        .G   (G2[2]),
        .Cin (1'b0),
        .C   (C[6])
    );
    
    CU CU7(
        .P   (P2[3]),
        .G   (G2[3]),
        .Cin (1'b0),
        .C   (C[7])
    );

    CU CU8(
        .P   (P2[4]),
        .G   (G2[4]),
        .Cin (1'b0),
        .C   (Cout)
    );



endmodule