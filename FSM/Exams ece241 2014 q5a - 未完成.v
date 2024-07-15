module top_module (
    input clk,
    input areset,
    input x,
    output z
); 
    parameter A = 0, B = 1, C = 2, D = 3;
    reg [1:0] state, next_state;
 
    always @(*) begin
        case (state)
            A: next_state = x ? B : A;
            B: next_state = x ? C : D;
            C: next_state = x ? C : D;
            D: next_state = x ? D : C;
        endcase
    end
    always @(posedge clk or posedge areset) begin
        if (areset) begin
           state <= A; 
        end else begin
           state <= next_state; 
        end
    end
    always @(posedge clk or posedge areset) begin
        if (areset) begin
           z <= 0; 
        end else if (state == A) begin
           z <= x; 
        end else if (state == B) begin
           z <= ~x; 
        end else if (state == C) begin
           z <= ~x;
        end else if (state == D) begin
           z <= ~x;
        end
    end
endmodule
