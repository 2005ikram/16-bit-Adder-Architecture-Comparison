module full_adder (
    input  A,
    input  B,
    input  Cin,
    output Sum,
    output Cout
);

    wire P;
    wire G;

    assign P = A ^ B;
    assign G = A & B;

    assign Sum  = P ^ Cin;
    assign Cout = G | (P & Cin);

endmodule
