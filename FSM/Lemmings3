
module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging ); 

    parameter LEFT = 0, RIGHT=1, FALL_L = 2, FALL_R = 3, DIG_L = 4, DIG_R = 5;
    reg [2:0] state, next_state;
    
    always @(*) begin
       
        case (state)
            LEFT: begin
               
                if (!ground) begin
                   next_state =  FALL_L;
                end else begin
                    if (dig) begin
                        next_state = DIG_L;
                    end else if (bump_left) begin
                        next_state = RIGHT;
                    end else begin
                        next_state = LEFT; 
                    end
                end
            end
            
            RIGHT: begin
               
                if (!ground) begin
                   next_state =  FALL_R;
                end else begin
                    if (dig) begin
                        next_state = DIG_R;
                    end else if (bump_right) begin
                        next_state = LEFT;
                    end else begin
                        next_state = RIGHT; 
                    end
                end
            end
            
            FALL_R: begin
               
                if (!ground) begin
                    next_state =  FALL_R;
                end else begin
                    next_state = RIGHT;
                end
            end
            
            FALL_L: begin
               
                if (!ground) begin
                    next_state =  FALL_L;
                end else begin
                    next_state = LEFT;
                end
            end
            
            DIG_L: begin
               
                if (ground) begin
                    next_state =  DIG_L;
                end else begin
                    next_state = FALL_L;
                end
            end
            
            DIG_R: begin
               
                if (ground) begin
                    next_state =  DIG_R;
                end else begin
                    next_state = FALL_R;
                end
            end
            
        endcase
    end
    
    always @(posedge clk or posedge areset) begin
       
        if (areset) begin
            state <= LEFT;
        end else begin
            state <= next_state; 
        end
        
    end
    
    assign walk_left = (state == LEFT);
    assign walk_right = (state == RIGHT);
    assign aaah = (state == FALL_L)||(state == FALL_R);
    assign digging = (state == DIG_L)||(state == DIG_R);
    
    
    //output walk_left,
    //output walk_right,
    //output aaah,
    //output digging );     
        
endmodule
