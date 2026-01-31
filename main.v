`timescale 1ns / 1ps

module main(
    input  wire [7:0] D,        
    input  wire [2:0] S,        
    input  wire LE,             
    input  wire CP,             
    input  wire OE1, OE2, OE3,  

    output wire Y,              
    output wire Yn              
);

    reg [2:0] sel_latched;

    always @(negedge LE or posedge CP) begin
        if (!LE)
            sel_latched <= S;
        else
            sel_latched <= sel_latched;   
    end

    reg selected_data;

    always @(*) begin
        case (sel_latched)
            3'b000: selected_data = D[0];
            3'b001: selected_data = D[1];
            3'b010: selected_data = D[2];
            3'b011: selected_data = D[3];
            3'b100: selected_data = D[4];
            3'b101: selected_data = D[5];
            3'b110: selected_data = D[6];
            3'b111: selected_data = D[7];
            default: selected_data = 1'b0;
        endcase
    end
    reg reg_data;

    always @(posedge CP) begin
        reg_data <= selected_data;
    end

    wire oe_active = (OE1 == 1'b0) && (OE2 == 1'b0) && (OE3 == 1'b1);

    assign Y  = oe_active ? reg_data  : 1'bz;
    assign Yn = oe_active ? ~reg_data : 1'bz;

endmodule
