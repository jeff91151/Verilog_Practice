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

    parameter LEFT = 0, RIGHT=1, FALL_L = 2, FALL_R = 3, DIG_L = 4, DIG_R = 5, SPLAT = 6;
    reg [2:0] state, next_state;
    // 使用counter，因為是 20s ，得用5個bits(32位元)來表之。 但這樣不成功
    // reg [4:0] count;  -- failure
    // 原因: 位寬限制所導致
    reg [6:0] count;
    
    //method 2
    //因為改bit這件事蠻蠢的，則使用另一個變數，若count已經到20，則我們將此變數保持高電平
    //reg timeout;
    
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
                if (!ground) begin  //若沒有地板繼續掉落
                    next_state =  FALL_R;
                end else if (count > 20) begin //若有地板同時 count 大於 20s ，則會splat
                    next_state = SPLAT;
                end else begin
                    next_state = RIGHT; 
                end
            end
            
            FALL_L: begin
                if (!ground) begin
                    next_state =  FALL_L;
                end else if (count > 20) begin
                    next_state = SPLAT;
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
            
            SPLAT: begin
                next_state = SPLAT; //splat之後便出不去，故無法有其他動作
            end
                
        endcase
    end
    
    always @(posedge clk or posedge areset) begin
        
        if (areset) begin
            state <= LEFT;
            count <= 0; // 重啟後將 count 重置
        end else begin
            state <= next_state; 
            if ((next_state == FALL_R) ||(next_state == FALL_L)) begin // 如果下一個狀態是fall，皆要+1個clock
               count <= count + 1; 
            end else begin  // 如果是做除了splat的狀態，重設至0
               count <= 0; 
            end
        end
        
    end
    
    assign walk_left = (state == LEFT);
    assign walk_right = (state == RIGHT);
    assign aaah = (state == FALL_L)||(state == FALL_R);
    assign digging = (state == DIG_L)||(state == DIG_R);
    
endmodule
