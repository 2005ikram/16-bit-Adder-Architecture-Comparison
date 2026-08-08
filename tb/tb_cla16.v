`timescale 1ns/1ps

module tb_cla16;

    reg [15:0] A, B;
    reg Cin;

    wire [15:0] Sum;
    wire Cout;

    cla16 dut (
        .A(A),
        .B(B),
        .Cin(Cin),
        .Sum(Sum),
        .Cout(Cout)
    );

    initial begin
        $dumpfile("cla16.vcd");
        $dumpvars(0, tb_cla16);

        A = 16'h0000; B = 16'h0000; Cin = 0; #10;
        A = 16'h0001; B = 16'h0001; Cin = 0; #10;
        A = 16'hFFFF; B = 16'h0001; Cin = 0; #10;
        A = 16'hFFFF; B = 16'hFFFF; Cin = 0; #10;
        A = 16'h1234; B = 16'h5678; Cin = 0; #10;
        A = 16'hAAAA; B = 16'h5555; Cin = 1; #10;

        $finish;
    end

endmodule
