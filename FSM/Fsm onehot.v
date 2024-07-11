module top_module(
    input in,
    input [9:0] state,
    output [9:0] next_state,
    output out1,
    output out2);

    parameter S0 = 0;  // state 0
    parameter S1 = 1;  // state 1
    parameter S2 = 2;  //...
    parameter S3 = 3;
    parameter S4 = 4;
    parameter S5 = 5;
    parameter S6 = 6;
    parameter S7 = 7;  // ...
    parameter S8 = 8;  // state 8
    parameter S9 = 9; // state 9
    
    
    // assign next_state[0] = !in && (state[0] | state[1] | state[2] | state[3] | state[4] | state[7] | state[8] | state[9]);
    
    
    assign next_state[0] = !in && (state[S0] | state[S1] | state[S2] | state[S3] | state[S4] | state[S7] | state[S8] | state[S9]);
    assign next_state[1] = in && (state[S0] | state[S8] | state[S9]) ;
    assign next_state[2] = in && state[S1];
    assign next_state[3] = in && state[S2];
    assign next_state[4] = in && state[S3];
    assign next_state[5] = in && state[S4];
    assign next_state[6] = in && state[S5];
    assign next_state[7] = in && (state[S6]|state[S7]);
    assign next_state[8] = !in && state[S5];
    assign next_state[9] = !in && state[S6];
    

    assign out1 = (state[S8])|(state[S9]);
    assign out2 = (state[S7])|(state[S9]);
    
endmodule
