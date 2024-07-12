module top_module(
    input clk,
    input reset,    // Synchronous reset
    input in,
    output disc,
    output flag,
    output err);

    parameter none = 0, one = 1, two = 2, three = 3, four = 4, five = 5, six = 6, error = 7, discard = 8, flag_parameter = 9;
    reg [3:0] state, next_state ;
    
    always @(posedge clk) begin
        
        if (reset) begin
           state <= none; 
        end else begin
            
           state <= next_state; 
        end
    end
    always @(*) begin
        
        case (state) 
            none: next_state = in ? one : none;
            one: next_state = in ? two : none;
            two: next_state = in ? three : none;
            three: next_state = in ? four : none;
            four: next_state = in ? five : none;
            five: next_state = in ? six : discard;
            six: next_state = in ? error : flag_parameter;
            discard: next_state = in ? one : none;
            flag_parameter: next_state = in ? one : none;
            error: next_state = in ? error : none;
        endcase
    end
    
    assign disc = (state == discard);
    assign flag = (state == flag_parameter);
    assign err = (state == error);
    
endmodule

