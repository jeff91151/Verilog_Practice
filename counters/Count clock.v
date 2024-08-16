module top_module(
    input clk,
    input reset,
    input ena,
    output pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss); 
    
    always @(posedge clk) begin
        if (reset) begin
            pm <= 0;
            hh <= 8'h12;
            mm <= 0;
            ss <= 0;
        end else if (ena) begin
            if (!pm) begin // midnight
                if (hh == 8'h11 && mm == 8'h59 && ss == 8'h59) begin
                    pm <= 1;
                    hh <= 8'h12;
                    mm <= 0;
                    ss <= 0;
                end else if (hh[7:4] == 4'h1 && hh[3:0] == 4'h2 && mm[7:4] == 4'h5 && mm[3:0] == 4'h9 && ss[7:4] == 4'h5 && ss[3:0] == 4'h9) begin // 這裡我寫的搞剛，可以不用切太細
                    hh <= 1;
                    mm <= 0;
                    ss <= 0;
                end else if (hh[3:0] == 4'h9 && mm[7:4] == 4'h5 && mm[3:0] == 4'h9 && ss[7:4] == 4'h5 && ss[3:0] == 4'h9) begin
                    hh[7:4] <= hh[7:4] + 1;
                    hh[3:0] <= 0;
                    mm[7:4] <= 0;
                    mm[3:0] <= 0;
                    ss[7:4] <= 0;
                    ss[3:0] <= 0;
                end else if (mm[7:4] == 4'h5 && mm[3:0] == 4'h9 && ss[7:4] == 4'h5 && ss[3:0] == 4'h9) begin
                    hh[3:0] <= hh[3:0] + 1;
                    mm[7:4] <= 0;
                    mm[3:0] <= 0;
                    ss[7:4] <= 0;
                    ss[3:0] <= 0;
                end else if (mm[3:0] == 4'h9 && ss[7:4] == 4'h5 && ss[3:0] == 4'h9) begin
                    mm[7:4] <= mm[7:4] + 1;
                    mm[3:0] <= 0;
                    ss[7:4] <= 0;
                    ss[3:0] <= 0;
                end else if (ss[7:4] == 4'h5 && ss[3:0] == 4'h9) begin
                    mm[3:0] <= mm[3:0] + 1;
                    ss[7:4] <= 0;
                    ss[3:0] <= 0;
                end else if (ss[3:0] == 4'h9) begin
                    ss[7:4] <= ss[7:4] + 1;
                    ss[3:0] <= 0;
                end else begin
                	ss <= ss + 1;
                end
            end else begin // noon
                if (hh == 8'h11 && mm == 8'h59 && ss == 8'h59) begin
                    pm <= 0;
                    hh <= 8'h12;
                    mm <= 0;
                    ss <= 0;
                end else if (hh[7:4] == 4'h1 && hh[3:0] == 4'h2 && mm[7:4] == 4'h5 && mm[3:0] == 4'h9 && ss[7:4] == 4'h5 && ss[3:0] == 4'h9) begin
                    hh <= 1;
                    mm <= 0;
                    ss <= 0;
                end else if (hh[3:0] == 4'h9 && mm[7:4] == 4'h5 && mm[3:0] == 4'h9 && ss[7:4] == 4'h5 && ss[3:0] == 4'h9) begin
                    hh[7:4] <= hh[7:4] + 1;
                    hh[3:0] <= 0;
                    mm[7:4] <= 0;
                    mm[3:0] <= 0;
                    ss[7:4] <= 0;
                    ss[3:0] <= 0;
                end else if (mm[7:4] == 4'h5 && mm[3:0] == 4'h9 && ss[7:4] == 4'h5 && ss[3:0] == 4'h9) begin
                    hh[3:0] <= hh[3:0] + 1;
                    mm[7:4] <= 0;
                    mm[3:0] <= 0;
                    ss[7:4] <= 0;
                    ss[3:0] <= 0;
                end else if (mm[3:0] == 4'h9 && ss[7:4] == 4'h5 && ss[3:0] == 4'h9) begin
                    mm[7:4] <= mm[7:4] + 1;
                    mm[3:0] <= 0;
                    ss[7:4] <= 0;
                    ss[3:0] <= 0;
                end else if (ss[7:4] == 4'h5 && ss[3:0] == 4'h9) begin
                    mm[3:0] <= mm[3:0] + 1;
                    ss[7:4] <= 0;
                    ss[3:0] <= 0;
                end else if (ss[3:0] == 4'h9) begin
                    ss[7:4] <= ss[7:4] + 1;
                    ss[3:0] <= 0;
                end else begin
                	ss <= ss + 1;
                end
            end
        end else begin
            pm <= pm;
            hh <= hh;
            mm <= mm;
            ss <= ss;
        end
    end
    
endmodule
