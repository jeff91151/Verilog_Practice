module top_module (input a, input b, input c, output out);//

    // 用個 wire 先將out hold 住，再來反轉
    // 因為是5輸入的andgate，所以在外加兩個1，不影響結果
    wire out_wire;
    andgate inst1 ( .a(a), .b(b), .c(c), .d(1'b1), .e(1'b1), .out(out_wire) );
    assign out = ~out_wire;

endmodule
