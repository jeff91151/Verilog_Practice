module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input x,
    input y,
    output f,
    output g
); 
	parameter A = 0, B = 1, C = 2, D = 3, E = 4, F = 5, G = 6, H = 7, I = 8, J = 9, K = 10;
    reg [3:0] state, next_state;
    
    always @(*) begin
       
        case (state)
            A: next_state = B;
            B: next_state = C;
            C: next_state = x ? D : C;
            D: next_state = x ? D : E;
            E: next_state = x ? F : C;
            F: next_state = G;
            G: next_state = y ? H : I;
            H: next_state = J;
            I: next_state = y ? J : K;
            J: next_state = J;
            K: next_state = K;
        endcase
        
    end
    always @(posedge clk) begin
        if (!resetn) begin
           state <= A;  
        end else begin
           state <= next_state; 
        end
    end
    assign f = (state == B) ;
    assign g = (state == G)||(state == H)||(state == J)||(state == F);
    
    
endmodule
