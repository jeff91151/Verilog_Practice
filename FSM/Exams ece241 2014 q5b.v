module top_module (
    input clk,
    input areset,
    input x,
    output z
); 
    
    parameter A = 0, B = 1;
    reg [1:0] state, next_state;

    always @(*) begin
        
        case (state)
            
            A: next_state = x ? B : A;
            B: next_state = B;
            default: next_state = A;
            
        endcase
        
    end
    
    always @(posedge clk or posedge areset) begin
        
        if (areset) begin
           state <= A; 
        end else begin
            
           state <= next_state; 
        end
        
    end
    assign z = ((state == B)&&(x == 0)) ||((state == A)&&(x == 1));
endmodule
