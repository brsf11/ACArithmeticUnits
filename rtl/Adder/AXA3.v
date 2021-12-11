module AXA3(input wire A,B,Cin,
            output wire Sum,Cout);

    wire temp;

    assign temp = !(A^B);
    assign Sum  = temp&Cin;
    assign Cout = (temp&A)|((!temp)&Cin);

endmodule
