`timescale 1ns/1ps

module fractional_delay();

reg a = 0;

always #1.5 a = !a;

initial begin
    $display("time\ta");
    $monitor("%h\t%b", $time, a);
    $dumpfile("test.vcd");
    $dumpvars(0, a);
    #10.6 $finish;
end

endmodule
