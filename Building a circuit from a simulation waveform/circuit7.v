module top_module (
    input clk,
    input a,
    output q );

    always @(posedge clk) begin
        if (!a) begin
           q <= 1; 
        end else begin
            q <= 0;
        end
    end
    
endmodule
