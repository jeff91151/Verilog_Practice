module top_module(
    input in,
    input [9:0] state,
    output [9:0] next_state,
    output out1,
    output out2);

    parameter S0 = 10'b0000000001;  // state 0
    parameter S1 = 10'b0000000010;  // state 1
    parameter S2 = 10'b0000000100;  //...
    parameter S3 = 10'b0000001000;
    parameter S4 = 10'b0000010000;
    parameter S5 = 10'b0000100000;
    parameter S6 = 10'b0001000000;
    parameter S7 = 10'b0010000000;  // ...
    parameter S8 = 10'b0100000000;  // state 8
    parameter S9 = 10'b1000000000; // state 9
    
    always @(*) begin
        
        case (state)
            S0: next_state = in ? S1 : S0;
            S1: next_state = in ? S2 : S0;
            S2: next_state = in ? S3 : S0;
            S3: next_state = in ? S4 : S0;
            S4: next_state = in ? S5 : S0;
            S5: next_state = in ? S6 : S8;
            S6: next_state = in ? S7 : S9;
            S7: next_state = in ? S7 : S0;
            S8: next_state = in ? S1 : S0;
            S9: next_state = in ? S1 : S0; 
        	default: next_state = 10'b0; // 其餘state的情況，給0
        endcase
        
    end
    
    assign out1 = (state == S8)|(state == S9);
    assign out2 = (state == S7)|(state == S9);
    
endmodule
