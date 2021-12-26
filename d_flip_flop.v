// A standard flip-flop (not sure exactly how it is supposed to work)

module dff_from_nand(q, q_bar, clk, d);

output q, q_bar;
input clk, d;

wire clk, d, q, q_bar;

nand(x, clk, d);
nand(y, x, clk);
nand(q, x, q_bar);
nand(q_bar, y, q);

endmodule


module dff_from_nand_tb();

reg clk, d;
wire q, q_bar;

dff_from_nand D (q, q_bar, clk, d);

initial begin
    $display("clk\td\tx\ty\tq\tq_bar");
    $monitor("%h\t%b\t%b\t%b\t%b\t%b", 
             clk, d, D.x, D.y, q, q_bar);
    clk = 0;
    d = 0;
    #3 d = 1;
    #3 d = 0;
    #10 $finish;
end

always #2 clk = ~clk;

endmodule
