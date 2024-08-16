module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    output [3:1] ena,
    output [15:0] q);

    reg [3:0] ena_test;
    always @(posedge clk) begin
        if (reset) begin
           ena <= 0;
           q <= 0;
        end else begin
            if (q[15:12] == 4'd9 && q[11:8] == 4'd9 && q[7:4] == 4'd9 && q[3:0] == 4'd9) begin
                q <= 0;
            end else if (q[11:8] == 4'd9 && q[7:4] == 4'd9 && q[3:0] == 4'd9) begin
                q[15:12] <= q[15:12] + 1;
                q[3:0] <= 0;
                q[7:4] <= 0;
                q[11:8] <= 0;
            end else if (q[7:4] == 4'd9 && q[3:0] == 4'd9) begin
                q[11:8] <= q[11:8] + 1;
                q[3:0] <= 0;
                q[7:4] <= 0;
            end else if (q[3:0] == 4'd9) begin
                q[7:4] <= q[7:4] + 1;
                q[3:0] <= 0;
            end else begin
                q[3:0] <= q[3:0] + 1;
            end
            
            if (q[11:8] == 4'd9 && q[7:4] == 4'd9 && q[3:0] == 4'd8) begin
                ena[3] <= 1;
                ena[2] <= 1;
                ena[1] <= 1;
            end else if (q[7:4] == 4'd9 && q[3:0] == 4'd8) begin
                ena[2] <= 1;
                ena[1] <= 1;
            end else if (q[3:0] == 4'd8) begin
                
                ena[1] <= 1;
            end else begin
               ena <= 0; 
            end
        end
    end
    
endmodule
