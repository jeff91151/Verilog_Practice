module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4);

    // Y2 -> 僅第 2 位為1 --> 000010 (B)
    // Y4 -> 僅第 4 位為1 --> 001000 (D)
    
    assign Y2 = y[1] && (w == 0) ;
    assign Y4 = (w == 1) && (y[2]||y[3]||y[6]||y[5]) ; 
    
endmodule
