module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output shift_ena,
    output counting,
    input done_counting,
    output done,
    input ack );

    parameter A = 0, B = 1, C = 2, D = 3, E = 4, F = 5, G = 6, H = 7 , I = 8, J = 9;
    reg [3:0] next_state, state;
    
    always @(*) begin
        case (state)
            A: next_state = data ? B : A; // data == 1 => B
            B: next_state = data ? C : A; // data == 1 => C
            C: next_state = data ? C : D; // data == 0 => D
            D: next_state = data ? E : A; // data == 1 => E
            E: next_state = F;
            F: next_state = G;
            G: next_state = H;
            H: next_state = I;
            I: next_state = done_counting ? J : I;
            J: next_state = ack ? A : J;
        endcase
    end
    always @(posedge clk) begin
        if (reset) begin
           state <= A; 
        end else begin
           state <= next_state; 
        end
    end
    assign shift_ena = (state == E)||(state == F) || (state == G) || (state == H) ;
    assign counting = (state == I);
    assign done = (state == J);
    
endmodule
