module RCA(input wire[7:0]  A,B,
           input wire       Cin,
           output wire[7:0] Sum,
           output wire      Cout);
    wire [8:0] F,C;

    RCPFA1 RCPFA1_0(
        .A(A[0]),
        .B(B[0]),
        .Cin(C[1]),
        .Fin(Cin),
        .Cout(C[0]),
        .Fout(F[1]),
        .S(Sum[0])
    );

    RCPFA1 RCPFA1_1(
        .A(A[1]),
        .B(B[1]),
        .Cin(C[2]),
        .Fin(F[1]),
        .Cout(C[1]),
        .Fout(F[2]),
        .S(Sum[1])
    );

    RCPFA1 RCPFA1_2(
        .A(A[2]),
        .B(B[2]),
        .Cin(C[3]),
        .Fin(F[2]),
        .Cout(C[2]),
        .Fout(F[3]),
        .S(Sum[2])
    );

    RCPFA1 RCPFA1_3(
        .A(A[3]),
        .B(B[3]),
        .Cin(C[4]),
        .Fin(F[3]),
        .Cout(C[3]),
        .Fout(F[4]),
        .S(Sum[3])
    );

    RCPFA1 RCPFA1_4(
        .A(A[4]),
        .B(B[4]),
        .Cin(C[5]),
        .Fin(F[4]),
        .Cout(C[4]),
        .Fout(F[5]),
        .S(Sum[4])
    );

    RCPFA1 RCPFA1_5(
        .A(A[5]),
        .B(B[5]),
        .Cin(C[6]),
        .Fin(F[5]),
        .Cout(C[5]),
        .Fout(F[6]),
        .S(Sum[5])
    );

    RCPFA1 RCPFA1_6(
        .A(A[6]),
        .B(B[6]),
        .Cin(C[7]),
        .Fin(F[6]),
        .Cout(C[6]),
        .Fout(F[7]),
        .S(Sum[6])
    );

    RCPFA1 RCPFA1_7(
        .A(A[7]),
        .B(B[7]),
        .Cin(C[8]),
        .Fin(F[7]),
        .Cout(C[7]),
        .Fout(F[8]),
        .S(Sum[7])
    );
     
    assign Cout = F[8];
    assign C[8] = F[8]; 
endmodule
