// an AND gate buit from two NAND gates

module and_from_nands(out, in0, in1);

input in0, in1;
output out;

wire out, in0, in1;
wire intermediate;

nand(intermediate, in0, in1);
nand(out, intermediate, intermediate);

endmodule


module and_from_nands_tb();

reg in0, in1;
wire out;

and_from_nands N(out, in0, in1);

initial begin
    $display("in0\tin1\tout");
    $monitor("%b\t%b\t%b", in0, in1, out);
    in0 <= 0;
    in1 <= 0;
    #1 in0 <= 1;
    #1 in0 <= 0;
    in1 <= 1;
    #1 in0 <= 1;
    #1 $finish;
end

endmodule
