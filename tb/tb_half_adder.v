`timescale 1ns/1ps

module tb_half_adder;

    reg A, B;
    wire S, C;

    half_adder dut (
        .A(A),
        .B(B),
        .S(S),
        .C(C)
    );

    initial begin
        $dumpfile("half_adder.vcd");
        $dumpvars(0, tb_half_adder);

        A = 0; B = 0; #10;
        A = 0; B = 1; #10;
        A = 1; B = 0; #10;
        A = 1; B = 1; #10;

        $finish;
    end

endmodule
