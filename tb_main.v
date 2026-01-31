`timescale 1ns / 1ps

module tb_main;

    reg  [7:0] D;
    reg  [2:0] S;
    reg        LE;
    reg        CP;
    reg        OE1, OE2, OE3;

    wire       Y;
    wire       Yn;

    main uut (
        .D(D),
        .S(S),
        .LE(LE),
        .CP(CP),
        .OE1(OE1),
        .OE2(OE2),
        .OE3(OE3),
        .Y(Y),
        .Yn(Yn)
    );

    initial begin
        CP = 0;
        forever #10 CP = ~CP;
    end

    initial begin
        $monitor("t=%0t | D=%b | S=%b | LE=%b | OE1=%b OE2=%b OE3=%b | Y=%b Yn=%b",
                 $time, D, S, LE, OE1, OE2, OE3, Y, Yn);

        D   = 8'b1010_1100;
        S   = 3'b000;
        LE  = 0;
        OE1 = 0;
        OE2 = 0;
        OE3 = 1;

        #25  S = 3'b011;
        #20  LE = 1; S = 3'b111;
        #40  D = 8'b0101_0001;
        #40  OE1 = 1;
        #20  OE1 = 0; OE2 = 1;
        #20  OE2 = 0; OE3 = 0;
        #20  OE3 = 1;
        #100 $stop;
    end

endmodule
