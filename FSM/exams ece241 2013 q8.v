module top_module (
    input clk,
    input aresetn,    // Asynchronous active-low reset
    input x,
    output z ); 

    parameter none = 0 , s1 = 1, s2 = 2;
    reg [1:0] state, next_state;
    
    always @(posedge clk, negedge aresetn) begin
        if (aresetn == 0) begin
           state <= none; 
        end else begin
           state <= next_state; 
        end
    end
    always @(*) begin
        case (state)
            none: next_state = x ? s1 : none;
            s1: next_state = !x ? s2 : s1;
            s2: next_state = x ? s1 : none;
        endcase
    end
    
    assign z = (state == s2) &&  x == 1;
    
endmodule
