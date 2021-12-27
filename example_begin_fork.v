module fork_join();

reg a, b, c, d;

initial begin

    $display("Starting simulation\n");
    $display("time\ta\tb\tc\td\n");
    $monitor("%h\t%b\t%b\t%b\t%b", $time, a, b, c, d);
   
    // sequential asignment
    #1 a <= 0;
    #2 b <= 0;
    #3 c <= 0;
    #4 d <= 0;

    // parallel asignment
    fork: F
        #1 a <= 1;
        #2 b <= 1;
        #3 c <= 1;
        #4 d <= 1;
    join

    #1 $display("\nTerminating simulation");

end

endmodule
