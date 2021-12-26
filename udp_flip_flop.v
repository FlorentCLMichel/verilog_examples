primitive flip_flop(out, in); 

output out;
input in;

reg out;

initial out = 0;

table
    (01) : 0 : 1;
    (01) : 1 : 0;
    (?0) : 0 : 0;
    (?0) : 1 : 1;
    (1?) : 0 : 0;
    (1?) : 1 : 1;
endtable

endprimitive


module test();

wire out;
reg in;

flip_flop(out, in);

initial begin
    $display("in\tout");
    $monitor("%b\t%b", in, out);
    in = 0;
    #1 in = 1;
    #2 in = 0;
    #2 in = 1;
    #10 in = 0;
    #3 in = 1;
    #4 in = 0;
    #5 in = 1;
    #6 in = 0;
    #1 $finish;
end

endmodule
