module top_module (
    input sel,
    input [7:0] a,
    input [7:0] b,
    output [7:0] out  );

  //assign out = (~sel & a) | (sel & b);  因為sel 是 1個bit， 而a跟b 都是 8bit，故不能用bitwise
  
  //assign out = sel ? a : b;
    always @(*) begin
        case (sel)
            0: out = b;
            1: out = a;
        endcase
    end
    
endmodule
