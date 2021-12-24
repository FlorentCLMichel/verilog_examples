`include "parity.v"

module parity_tb();

reg a, b, c, d;
wire y;
    
initial begin
    $display ("time\ta\tb\tc\td\ty");
    $monitor ("%g\t%b\t%b\t%b\t%b\t%b", 
              $time, a, b, c, d, y);
    $dumpfile("test.vcd");
    $dumpvars(0, a, b, c, d, y);
    a <= 0;
    b <= 0;
    c <= 0;
    d <= 0;
    #16 $finish;
end

always begin
    if (a == 1) begin
        if (b == 1) begin
            if (c == 1) begin
                d <= ~d;
            end 
            c <= ~c;
        end 
        b <= ~b;
    end 
    #1 a <= ~a;
end
    
parity P (a, b, c, d, y);

endmodule
