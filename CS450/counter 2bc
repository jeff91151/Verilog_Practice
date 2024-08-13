module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output [1:0] state
);
	parameter SNT=0, WNT=1, ST=2, WT=3;
    reg [1:0] next_state, c_state;
    
    always @(*) begin
        case(c_state)
            SNT: begin
                if (!train_valid) begin
                    next_state = SNT;
                end else begin
                    next_state = train_taken ? WNT : SNT;
                end
            end
            WNT: begin
                if (!train_valid) begin
                    next_state = WNT;
                end else begin
                    next_state = train_taken ? ST : SNT;
                end
            end
            ST: begin
                if (!train_valid) begin
                    next_state = ST;
                end else begin
                    next_state = train_taken ? WT : WNT;
                end
            end
            WT: begin
                if (!train_valid) begin
                    next_state = WT;
                end else begin
                    next_state = train_taken ? WT : ST;
                end
            end
        endcase
    end
                
    always @(posedge clk or posedge areset) begin
        if (areset) begin
           c_state <= WNT;
        end else begin
            c_state <= next_state;
        end
    end
    always @(*) begin
        case (c_state) 
            SNT: state = 0;
            WNT: state = 1;
            ST: state = 2;
            WT: state = 3;
        endcase
    end
    
endmodule
