module mux_from_gates(y, c0, c1, c2, c3, a, b);

output y;
input c0, c1, c2, c3, a, b;

wire y, c0, c1, c2, c3, a, b;
wire y0, y1, y2, y3;
wire a_inv, b_inv;

not(a_inv, a);
not(b_inv, b);

and(y0, c0, a_inv, b_inv);
and(y1, c1, a_inv, b);
and(y2, c2, a, b_inv);
and(y3, c3, a, b);

or(y, y0, y1, y2, y3);

endmodule


module mux_from_gates_tb();

reg c0, c1, c2, c3, a, b;
wire y;

mux_from_gates M (y, c0, c1, c2, c3, a, b);

initial begin
    $display("c0\tc1\tc2\tc3\ta\tb\ty");
    $monitor("%b\t%b\t%b\t%b\t%b\t%b\t%b\t", c0, c1, c2, c3, a, b, y);
    c0 = 0;
    c1 = 0;
    c2 = 0;
    c3 = 0;
    a = 0;
    b = 0;
    #10 b = 1;
    #10 b = 0;
    a = 1;
    #10 b = 1;
    #10 $finish;
end

always #1 c0 = ~c0;
always #2 c1 = ~c1;
always #3 c2 = ~c2;
always #4 c3 = ~c3;

endmodule
