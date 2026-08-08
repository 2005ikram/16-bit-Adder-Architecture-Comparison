module ripple16 (
    input  [15:0] A,
    input  [15:0] B,
    input         Cin,
    output [15:0] Sum,
    output        Cout
);

    wire [16:0] C;

    assign C[0] = Cin;

    genvar i;

    generate
        for (i = 0; i < 16; i = i + 1) begin : FA_STAGE
            full_adder fa (
                .A    (A[i]),
                .B    (B[i]),
                .Cin  (C[i]),
                .Sum  (Sum[i]),
                .Cout (C[i+1])
            );
        end
    endgenerate

    assign Cout = C[16];

endmodule
