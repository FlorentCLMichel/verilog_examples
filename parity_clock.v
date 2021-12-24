// check the parity of a 4-bit input

module parity_clock ( clk, y );

input [3:0] clk;
output y;

wire [3:0] clk;
wire y;

wire u0, u1;

xor(u0, clk[0], clk[1]);
xor(u1, clk[2], clk[3]);
xor(y, u0, u1);

endmodule
