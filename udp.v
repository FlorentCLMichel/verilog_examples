primitive test(out, in0, in1, in2, in3, in4, in5, in6, in7, in8, in9, in10, in11); 

output out;
input in0, in1, in2, in3, in4, in5, in6, in7, in8, in9, in10, in11;

table

    0 0 ? ? ? ? ? ? ? ? ? 0 : 0;
    0 1 ? ? ? ? ? ? ? ? ? 0 : 1;
    1 0 ? ? ? ? ? ? ? ? ? 0 : 1;
    1 1 ? ? ? ? ? ? ? ? ? 0 : 0;
    0 0 ? ? ? ? ? ? ? ? ? 1 : 1;
    0 1 ? ? ? ? ? ? ? ? ? 1 : 0;
    1 0 ? ? ? ? ? ? ? ? ? 1 : 0;
    1 1 ? ? ? ? ? ? ? ? ? 1 : 1;

endtable

endprimitive


module udp_tb(); 

reg in0, in1, in2, in3, in4, in5, in6, in7, in8, in9, in10, in11;
wire out;

test T (out, in0, in1, in2, in3, in4, in5, in6, in7, in8, in9, in10, in11);

initial begin
    $display("in0\tin1\tout");
    $monitor("%b\t%b\t%b", in0, in1, out);
    in0 = 0;
    in1 = 0;
    in11 = 0;
    #1 in0 = 1;
    #1 in0 = 0; in1 = 1;
    #1 in0 = 1;
    #1 $finish;
end

endmodule
