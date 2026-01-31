`timescale 1ns / 1ps

module top(
    input  wire        CLK100MHZ,   
    input  wire [7:0]  D,           
    input  wire [2:0]  S,           
    input  wire        LE,          
    input  wire        OE1,         
    input  wire        OE2,         
    input  wire        OE3,         
    output wire        Y,           
    output wire        Yn           
);

    wire slow_cp;

    clock_divider #(
        .DIVISOR(50_000_000)      
    ) u_div (
        .clk_in  (CLK100MHZ),
        .reset_n (1'b1),
        .clk_out (slow_cp)
    );

    main u_main (
        .D   (D),
        .S   (S),
        .LE  (LE),
        .CP  (slow_cp),
        .OE1 (OE1),
        .OE2 (OE2),
        .OE3 (OE3),
        .Y   (Y),
        .Yn  (Yn)
    );

endmodule
