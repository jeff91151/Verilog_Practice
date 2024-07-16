module top_module (
    input clk,
    input reset,   // Synchronous reset
    input s,
    input w,
    output z
);

    parameter A = 0, B = 1;
    reg [1:0] next_state, state;
    
    always @(*) begin
        
        case (state)
            A: next_state = s ? B : A;
            B: next_state = B;
        endcase
    end
    
    always @(posedge clk) begin
        
        if (reset) begin
           state <= A ; 
        end else begin
           state <= next_state; 
        end
        
    end
    
    reg [2:0] count, count_w; // count 當計數，而 count_w 來當 w 的計數
    always @(posedge clk) begin
        
        if (reset || state == A) begin
            count <= 0;
            count_w <= 0;
        end else if (count == 3) begin
            count <= 1; 
            count_w <= w;
        end else begin
            count <= count + 1; 
            count_w <= count_w + w;
        end
    end
    
    assign z = (count == 3)&&(count_w == 2); // 若 w 為2，且在第三個cycle(count == 3)，則z 為高電平。 
    
endmodule
