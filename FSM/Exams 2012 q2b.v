module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

    // Y1 -> 000010 -> B
    // Y3 -> 001000 -> D
    
    assign Y1 = (w == 1)&&(y[0]); // y == A
    assign Y3 = (w == 0)&&(y[1]||y[2]||y[4]||y[5]); // y == B or y == C or y == E or y == F
    
endmodule
