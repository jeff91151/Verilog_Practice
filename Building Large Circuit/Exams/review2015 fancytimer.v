module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output [3:0] count,
    output counting,
    output done,
    input ack );

    // count 是 每1000個cycle會減一，故圖上看到從 1 -> 0 是因為已經經過1000個cycle了
    
    parameter A = 0, B = 1, C = 2, D = 3; //搜尋1101的狀態
    parameter shift_S0 = 4, shift_S1 = 5, shift_S2 = 6, shift_S3 = 7; // 搬移的狀態
    parameter count0 = 8; // 計數狀態
    parameter wait0 = 9;  // 等待act狀態
    reg [13:0] count_total; // 給14 bit， 2^14 = 16384，可涵蓋到最大值 15000。
    reg [3:0] delay, delay0; // delay主要是用在hold住總total值； 而delay0是拿來遞減，給予count值，每過1000cycle-1
    reg [3:0] next_state, state;
    
    always @(posedge clk) begin
        if (reset) begin
           state <= A; 
        end else begin
           state <= next_state; 
        end
    end
    
    always @(*) begin
        case (state)
            A: next_state = data ? B : A;
            B: next_state = data ? C : A;
            C: next_state = data ? C : D;
            D: next_state = data ? shift_S0 : A;
            shift_S0: next_state = shift_S1;
            shift_S1: next_state = shift_S2;
            shift_S2: next_state = shift_S3;
            shift_S3: next_state = count0;
            count0: next_state = (count_total == ((delay + 1)*1000)-1) ? wait0 : count0; // 數到 (n*1000) -1 
            wait0: next_state = ack ? A : wait0;
        endcase
    end
    always @(posedge clk) begin
       
        case(state) 
            shift_S0: begin
                delay0 = {delay0[2:0], data}; // 這裡會使用blocking，在於是那個當下要做的事，若用<=則會 延遲 一個cycle
            end
            shift_S1: begin
                delay0 = {delay0[2:0], data};
            end
            shift_S2: begin
                delay0 = {delay0[2:0], data};
            end
            shift_S3: begin
                delay0 = {delay0[2:0], data}; 
                count_total = 0;
                delay <= delay0; // 先賦值給delay，他會拿去做判斷是否達到 999 or 1999 etc..
            end
            count0:begin
                count_total = count_total + 1; //到了 count0 狀態，會開始計數，不過這裡我原本是用non-blocking
                // 原因是看圖應該是從0開始計數，則下一個cycle是應是1沒錯，但我這樣 submit會延遲一個cycle
                // 於是讓這裡變成 blocking， 這樣才會對 ， 有點不理解~
                if (count_total == 1000) begin
                    delay0 <= delay0 -1;
                end else if (count_total == 2000) begin
                    delay0 <= delay0 -1;
                end else if (count_total == 3000) begin
                    delay0 <= delay0 -1;
                end else if (count_total == 4000) begin
                    delay0 <= delay0 -1;
                end else if (count_total == 5000) begin
                    delay0 <= delay0 -1;
                end else if (count_total == 6000) begin
                    delay0 <= delay0 -1;
                end else if (count_total == 7000) begin
                    delay0 <= delay0 -1;
                end else if (count_total == 8000) begin
                    delay0 <= delay0 -1;
                end else if (count_total == 9000) begin
                    delay0 <= delay0 -1;
                end else if (count_total == 10000) begin
                    delay0 <= delay0 -1;
                end else if (count_total == 11000) begin
                    delay0 <= delay0 -1;
                end else if (count_total == 12000) begin
                    delay0 <= delay0 -1;
                end else if (count_total == 13000) begin
                    delay0 <= delay0 -1;
                end else if (count_total == 14000) begin
                    delay0 <= delay0 -1;
                end else if (count_total == 15000) begin
                    delay0 <= delay0 -1;
                end else begin
                    delay0 <= delay0;
                end
            end
            default: count_total = 0;
        endcase
        
    end
    assign count = delay0;
    assign counting = (state == count0);
    assign done = (state == wait0);
    
endmodule
