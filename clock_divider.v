`timescale 1ns / 1ps

`timescale 1ns / 1ps

module clock_divider #(
    parameter DIVISOR = 50_000_000  
)(
    input  wire clk_in,
    input  wire reset_n,
    output reg  clk_out
);

    reg [26:0] counter;

    always @(posedge clk_in or negedge reset_n) begin
        if (!reset_n) begin
            counter <= 27'd0;
            clk_out <= 1'b0;
        end else begin
            if (counter == DIVISOR - 1) begin
                counter <= 27'd0;
                clk_out <= ~clk_out;
            end else begin
                counter <= counter + 1'b1;
            end
        end
    end

endmodule
