// A simple model of a flip-flop using a XOR gate.


module sff(q, d);

output q;
input d;

wire d, x, y, z;
reg q;

// cut-off the signal to length 1
not #1 (z, d);
and(y, d, z);

// change the vaue of x if y is 1
xor(x, q, y);

initial q <= 0;

always #1 q <= x;

endmodule


module sff_tb();

wire q;
reg d;

sff S (q, d);

initial begin
    $dumpfile("test.vcd");
    $dumpvars(0, d, S.z, S.y, S.x, q);
    $display("time\td\tz\ty\tx\tq");
    $monitor("%h\t%b\t%b\t%b\t%b\t%b", $time, d, S.z, S.y, S.x, q);
    d = 0;
    #10 d = 1;
    #4 d = 0;
    #5 d = 1;
    #3 d = 0;
    #6 d = 1;
    #3 d = 0;
    #6 d = 1;
    #4 d = 0;
    #10 $finish;
end

endmodule
