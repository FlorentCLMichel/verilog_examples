module example_assign();

parameter N_BITS=4;

reg [N_BITS-1:0] a, b, c, d;
wire [N_BITS-1:0] y;

assign y = (a&b) | (c^d);

initial begin
    a = 0;
    b = 0;
    c = 0;
    d = 0;
    $display("a\tb\tc\td\ty");
    $monitor("%b\t%b\t%b\t%b\t%b", a, b, c, d, y);
    #100 $finish;
end

always #1 a = a + 1;
always #2 b = b + 1;
always #3 c = c + 1;
always #4 d = d + 1;

endmodule
