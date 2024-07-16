module top_module (
    input clk,
    input reset,   // Synchronous reset
    input x,
    output z
);

    parameter A = 0, B = 1, C = 2, D = 3, E = 4;
    reg [2:0] state, next_state;
    
    always @(*) begin
        
        case (state)
            A: next_state = x ? B : A;
            B: next_state = x ? E : B;
            C: next_state = x ? B : C;
            D: next_state = x ? C : B;
            E: next_state = x ? E : D;
        endcase
        
    end
    always @(posedge clk) begin
       
        if (reset) begin
           state <= A; 
        end else begin
           state <= next_state; 
        end
        
    end
    //assign z = ((state == E)&&(x==0)) || ((state == B)&&(x==1)) || ((state == E)&&(x==1));
    reg z_reg;
    always @(posedge clk) begin
       
        if (reset) begin
           z_reg <= 0;
        end else if (state == E) begin
           z_reg <= 1; 
        end else if ((state == B)&&(x==1)) begin
           z_reg <= 1;
        end else begin
           z_reg <= 0; 
        end
        
    end
    assign z = z_reg;
    
endmodule
