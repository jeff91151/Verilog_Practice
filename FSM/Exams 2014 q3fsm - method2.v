module top_module (
    input clk,
    input reset,   // Synchronous reset
    input s,
    input w,
    output z
);

    parameter A = 0, B = 1, C = 2, D = 3;
    reg [1:0] next_state, state;
    
    always @(*) begin
        
        case (state)
            A: next_state = s ? B : A;
            B: next_state = C;
            C: next_state = D;
            D: next_state = B;
        endcase
    end
    always @(posedge clk) begin
       
        if(reset) begin
           state <= A; 
        end else begin
           state <= next_state; 
        end
        
    end
    reg [2:0] count;
    always @(posedge clk) begin
        
        if (reset) begin
           count <= 0; 
        end else if (state == A) begin
           count <= 0;
        end else if (state == B) begin
           count <= w; 
        end else begin
           count <= count + w; 
        end
    end
    assign z = (count == 2) &&(state == B) ;
    
endmodule
