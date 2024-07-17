module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input [3:1] r,   // request
    output [3:1] g   // grant
); 

    //需求1: Each r[i] is an input signal to the FSM, and represents one of the three devices. -> r 代表控制訊號
    //需求2: The FSM stays in state A as long as there are no requests -> 可能是要特別設定 default
    //需求3: priority system... ->  這裡提到order的課題，要留意先後順序
    parameter A = 0, B = 1, C = 2, D = 3;
    reg [1:0] next_state, state;
    
    always @(*) begin
        case (state)
            A: begin
                if (r[1]) begin
                   next_state = B;
                end else if (r[2]) begin
                   next_state = C; 
                end else if (r[3]) begin
                   next_state = D; 
                end else begin
                   next_state = A; 
                end
            end
            B: begin
                if (r[1]) begin
                   next_state = B; 
                end else begin
                   next_state = A; 
                end
            end
            C: begin
                if (r[2]) begin
                   next_state = C; 
                end else begin
                   next_state = A; 
                end
            end
            D: begin
                if (r[3]) begin
                   next_state = D; 
                end else begin
                   next_state = A; 
                end
            end
            default: next_state = A;
        endcase
    end
    always @(posedge clk) begin
        if (!resetn) begin
           state <= A; 
        end else begin
           state <= next_state; 
        end
    end
    assign g[1] = (state == B) ; 
    assign g[2] = (state == C) ; 
    assign g[3] = (state == D) ; 
endmodule
