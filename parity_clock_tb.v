`include "parity_clock.v"

module parity_clock_tb();

reg [3:0] clk;
wire y;

initial begin
    $display ("time\tclk\ty");
    $monitor ("%g\t%h\t%b", 
              $time, clk, y);
    $dumpfile("test.vcd");
    $dumpvars(0, clk, y);
    clk <= 4'b0;
    #16 $finish;
end

always begin
    #1 clk <= clk + 1;
end

parity_clock P (clk, y);

endmodule
