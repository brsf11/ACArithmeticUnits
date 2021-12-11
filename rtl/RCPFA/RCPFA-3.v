module RCPFA3(
    input A,
    input B,
    input Cin,
    input Fin,
    output Cout,
    output Fout,
    output S
);

assign Fout = A;
assign S = (~Cin & Fin) | (~Cin & A) | (~Cin & B) | (A & B & Fin);
assign Cout = (Cin & Fin) | (Cin & ~A) | (Cin & ~B) | (~(A & B) & Fin);


endmodule