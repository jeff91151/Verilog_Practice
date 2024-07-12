module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); //
	
    // 後來大改原先的code，把狀態設定成跟圖上一樣，較易理解
	parameter idle = 0, start = 1, s0 = 2, s1 = 3, s2 = 4, s3 = 5, s4 = 6, s5 =7, s6 = 8, s7 = 9;
    parameter parity = 10, stop = 11, wait_parmeter = 12;
    reg [3:0] state, next_state;
    
    // fsm
    always @(*) begin
        case (state)
            idle: next_state = !in ? start : idle;
            start: next_state = s0;
            s0: next_state = s1;
            s1: next_state = s2;
            s2: next_state = s3;
            s3: next_state = s4;
            s4: next_state = s5;
            s5: next_state = s6;
            s6: next_state = s7;
            s7: next_state = parity;
            parity: next_state = in ? stop : wait_parmeter;
            stop: next_state = in ? idle : start;
            wait_parmeter: next_state = in ? idle : wait_parmeter; // stop 來晚的情況，等到高電平就能回到idle，重新讀取
            
        endcase  
    end
    
    
    always @(posedge clk) begin
        if (reset) begin
           state <= idle; 
        end else begin
           state <= next_state; 
        end
    end
    
    
    // done_parameter
    assign done = ( state == stop )&&( odd == 0 );
    
    // out_byte
    reg [7:0] out_byte_reg;
    
    always @(posedge clk) begin
        if (reset) begin
            out_byte_reg <= 0;
        end else begin
            case (next_state) 
            
                s0 : out_byte_reg[0] <= in;
            
                s1 : out_byte_reg[1] <= in;
            
                s2 : out_byte_reg[2] <= in;
            
                s3 : out_byte_reg[3] <= in;
            
                s4 : out_byte_reg[4] <= in;
            
                s5 : out_byte_reg[5] <= in;
            
                s6 : out_byte_reg[6] <= in;
            
                s7 : out_byte_reg[7] <= in;
            
                parity : out_byte_reg <= out_byte_reg;
            
                stop: out_byte_reg <= out_byte_reg;
                
                wait_parmeter: out_byte_reg <= out_byte_reg;
                default: out_byte_reg <= 0;
        
            endcase
    
        end
    end
        
    assign out_byte = done ? out_byte_reg : 0 ;
    
    
    // New: Add parity checking.
        
       
        
    wire odd, parity_reset;
    assign parity_reset = (reset || next_state == start); 
    parity instance1 (clk, parity_reset, in, odd);
    
endmodule
