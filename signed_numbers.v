// Signed numbers example

`include "addbit.v"

module signed_numbers;

reg [31:0] a; // a 32-bit register

initial begin

    a = 32'h1;
    $display("current value of a: %h", a);
    a = -32'h1;
    $display("current value of a: %h", a);
    a = 32'hFFFF_FFFF;
    $display("current value of a: %h", a);
    a = -32'hFFFF_FFFF;
    $display("current value of a: %h", a);
    #10 $finish;

end

endmodule
