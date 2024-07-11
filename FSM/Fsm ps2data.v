module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output [23:0] out_bytes,
    output done); //
    
    // FSM from fsm_ps2
	parameter BYTE1 = 0, BYTE2 = 1, BYTE3 = 2, DONE = 3;
    reg [1:0] state, next_state;
    // State transition logic (combinational)
    always @(*) begin
        case (state)
            BYTE1: next_state = in[3] ? BYTE2 : BYTE1;
            BYTE2: next_state = BYTE3;
            BYTE3: next_state = DONE;
            DONE: next_state = in[3] ? BYTE2 : BYTE1; // 當in[3] == 0，必須讓下一個回到byte1；若是回到DONE，會導致done 拉到高電平
            
        endcase
    end
    
    // State flip-flops (sequential)
 
    always @(posedge clk) begin
        
        if (reset) begin
           state <= BYTE1; 
        end else begin
           state <= next_state; 
        end
        
    end
    // Output logic

    assign done = (state == DONE);
    // New: Datapath to store incoming bytes.
    
    reg [23:0] out_bytes_reg;
    always @(posedge clk) begin
        
        if (next_state == BYTE2) begin
            out_bytes_reg[23:16] <= in;
        end else if (next_state == BYTE3) begin
            out_bytes_reg[15:8] <= in;
        end else if (next_state == DONE) begin
            out_bytes_reg[7:0] <= in;
        end else begin
            out_bytes_reg <= 0;
        end
        
    end
    
    
    assign out_bytes = out_bytes_reg;

endmodule
