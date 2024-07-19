module top_module (
    input [1:0] sel, 
    input [7:0] a,
    input [7:0] b,
    input [7:0] c,
    input [7:0] d,
    output [7:0] out  ); // sel 00 01 10 11

    wire [7:0] mux0, mux1;
    mux2 mux0_instance ( sel[0],    a,    b, mux0 ); 
    mux2 mux1_instance ( sel[0],    c,    d, mux1 ); 
    mux2 mux2_instance ( sel[1], mux0, mux1,  out );

endmodule
