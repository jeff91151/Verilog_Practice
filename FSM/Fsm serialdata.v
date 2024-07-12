module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); //

    // Use FSM from Fsm_serial

    parameter start = 0, data = 1, stop = 2, done_parameter = 3, wait_par=4;
    reg [2:0] state, next_state;
    reg [2:0] count;
    always @(posedge clk) begin
        if (state == data) begin
            
            count = count + 1;
        end else begin
            count = 0; 
        end
    end
    always @(*) begin
       
        case (state)
            start: next_state = !in ?  data : start;
            data: next_state = (count == 7) ? stop : data;
            stop: next_state = in ? done_parameter : wait_par;
            // 原本沒加下面這行是錯的，原因是在stop若等不到 in = 1 的情況，則會一直卡住，
            // 則需要讓他進到下一個狀態(wait_par)，等到高電平就能進到start，
            // 不過這樣也讓參數變複雜 
            wait_par: next_state = in ? start : wait_par;  
            done_parameter: next_state = !in ? data :  start;
            
            
        endcase
    end
    
    always @(posedge clk) begin
       
        if (reset) begin
            state <= start;
        end else begin
            state <= next_state; 
        end
        
    end
    
    assign done = (state == done_parameter);
    
    // New: Datapath to latch input bits.
    reg [7:0] out_byte_reg;
    always @(posedge clk) begin
        if (state == data) begin
           
            out_byte_reg[count] <= in ;  // out_byte_reg[0] -> out_byte_reg[1] -> out_byte_reg[2]..
            
        end
        
        
    end
    assign out_byte = out_byte_reg;
endmodule
