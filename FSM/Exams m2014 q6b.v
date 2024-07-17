module top_module (
    input [3:1] y,
    input w,
    output Y2);

    parameter A = 0, B = 1, C = 2, D = 3, E = 4, F = 5;
    reg [2:0] next_state;
    
    always @(*) begin
        
        case (y)
            A: next_state = w ? A : B; //000
            B: next_state = w ? D : C; //001
            C: next_state = w ? D : E; //010
            D: next_state = w ? A : F; //011
            E: next_state = w ? D : E; //100
            F: next_state = w ? D : C; //101
        endcase
    end
    assign Y2 = (next_state == D)||(next_state == C);
    
endmodule
