// a simple parity tester

module parity(a, b, c, d, y);

input a, b, c, d;
output y;

wire a, b, c, d, y;

wire out_0, out_1;

xor u0(out_0, a, b);
xor u1(out_1, c, d);
xor u2 (y, out_0, out_1);

endmodule
