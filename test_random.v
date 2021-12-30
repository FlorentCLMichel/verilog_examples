module test_random();

reg [31:0] r;
integer seed = 42;

always #1 r = $urandom;

initial begin
    $urandom(seed);
    $monitor("%h", r);
    #10 $finish;
end

endmodule
