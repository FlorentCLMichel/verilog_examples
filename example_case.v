module mux(a, b, c, d, sel, y);

input a, b, c, d;
input [1:0] sel;
output y;

wire a, b, d, c;
wire [1:0] sel;
reg y;

always @ (a or b or c or d or sel)
case(sel)
    2'b00 : y = a;
    2'b01 : y = b;
    2'b10 : y = c;
    2'b11 : y = d;
    default : $display("Error in SEL");
endcase

endmodule


module mux_tb();

reg a, b, c, d;
reg [3:0] r;
reg [1:0] sel;
wire y;

mux M (a, b, c, d, sel, y);

initial begin
    r = $urandom;
    a = r%2;
    r = r / 2;
    b = r%2;
    r = r / 2;
    c = r%2;
    r = r / 2;
    d = r%2;
    sel = 1'b00;
    $display("a\tb\tc\td\tsel\ty");
    $monitor("%b\t%b\t%b\t%b\t%h\t%b", a, b, c, d, sel, y);
    #7 $finish;
end

always #2 sel = sel + 1;

endmodule
