module simple_counter(); 

reg [3:0] c = 0;
reg clock = 0;

always @ (posedge clock) c <= c + 1;

always #1 clock <= !clock;

initial begin
    $display("clock\tc");
    $monitor("%b\t%h", clock, c);
    #10 $finish;
end

endmodule
