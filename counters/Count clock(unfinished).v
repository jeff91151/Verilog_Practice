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
            hh <= 8'b00010010;
            mm <= 0;
            ss <= 0;
        end else if (ena) begin
            if (!pm) begin // midnight
                if (hh == 8'h11 && mm == 8'h59 && ss == 8'h59) begin
                    pm <= 1;
                    hh <= 8'd12;
                    mm <= 0;
                    ss <= 0;
                end else if (hh == 8'h12 && mm == 8'h59 && ss == 8'h59) begin
                    hh <= 1;
                    mm <= 0;
                    ss <= 0;
                end else if (mm == 8'h59 && ss == 8'h59) begin
                    hh <= hh + 1;
                    mm <= 0;
                    ss <= 0;
                end else if (ss == 8'h59) begin
                    mm <= mm + 1;
                    ss <= 0;
                end else begin
                	ss <= ss + 1;
                end
            end else begin // noon
                if (hh == 8'h11 && mm == 8'h59 && ss == 8'h59) begin
                    pm <= 0;
                    hh <= 8'd12;
                    mm <= 0;
                    ss <= 0;
                end else if (hh == 8'h12 && mm == 8'h59 && ss == 8'h59) begin
                    hh <= 1;
                    mm <= 0;
                    ss <= 0;
                end else if (mm == 8'h59 && ss == 8'h59) begin
                    hh <= hh + 1;
                    mm <= 0;
                    ss <= 0;
                end else if (ss == 8'h59) begin
                    mm <= mm + 1;
                    ss <= 0;
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
