module cla16 (
    input  [15:0] A,
    input  [15:0] B,
    input         Cin,
    output [15:0] Sum,
    output        Cout
);

    wire [3:0] PG;
    wire [3:0] GG;

    wire [4:0] C;

    assign C[0] = Cin;

    // Lookahead Carry Unit
    assign C[1] = GG[0] |
                  (PG[0] & C[0]);

    assign C[2] = GG[1] |
                  (PG[1] & GG[0]) |
                  (PG[1] & PG[0] & C[0]);

    assign C[3] = GG[2] |
                  (PG[2] & GG[1]) |
                  (PG[2] & PG[1] & GG[0]) |
                  (PG[2] & PG[1] & PG[0] & C[0]);

    assign C[4] = GG[3] |
                  (PG[3] & GG[2]) |
                  (PG[3] & PG[2] & GG[1]) |
                  (PG[3] & PG[2] & PG[1] & GG[0]) |
                  (PG[3] & PG[2] & PG[1] & PG[0] & C[0]);

    // Four 4-bit CLA blocks
    cla4 cla0 (
        .A    (A[3:0]),
        .B    (B[3:0]),
        .Cin  (C[0]),
        .Sum  (Sum[3:0]),
        .Cout (),
        .PG   (PG[0]),
        .GG   (GG[0])
    );

    cla4 cla1 (
        .A    (A[7:4]),
        .B    (B[7:4]),
        .Cin  (C[1]),
        .Sum  (Sum[7:4]),
        .Cout (),
        .PG   (PG[1]),
        .GG   (GG[1])
    );

    cla4 cla2 (
        .A    (A[11:8]),
        .B    (B[11:8]),
        .Cin  (C[2]),
        .Sum  (Sum[11:8]),
        .Cout (),
        .PG   (PG[2]),
        .GG   (GG[2])
    );

    cla4 cla3 (
        .A    (A[15:12]),
        .B    (B[15:12]),
        .Cin  (C[3]),
        .Sum  (Sum[15:12]),
        .Cout (),
        .PG   (PG[3]),
        .GG   (GG[3])
    );

    assign Cout = C[4];

endmodule
