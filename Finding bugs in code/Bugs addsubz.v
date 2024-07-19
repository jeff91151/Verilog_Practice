// synthesis verilog_input_version verilog_2001
module top_module ( 
    input do_sub,
    input [7:0] a,
    input [7:0] b,
    output reg [7:0] out,
    output reg result_is_zero
);//

    reg out_temp;
    always @(*) begin
        case (do_sub)
          0: out = a + b;
          1: out = a - b;
        endcase

        //out_temp = out[0]|out[1]|out[2]|out[3]|out[4]|out[5]|out[6]|out[7]; //若出來是 0 則代表 out是全 0
        out_temp = |out;
        //result_is_zero = out_temp ? 0 : 1;
        if (!out_temp) begin
            result_is_zero = 1;
        end else begin
           result_is_zero = 0; 
        end
    end

endmodule
