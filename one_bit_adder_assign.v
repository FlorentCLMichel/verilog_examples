module adder_assign(); 

reg a, b;
wire sum, carry;

// assign the result of a + b to carry and sum with delay 5
assign #5 {carry, sum} = a + b;

initial begin 
    $display("time\ta\tb\tsum\tcarry");
    $monitor("%h\t%b\t%b\t%b\t%b", $time, a, b, sum, carry);
    a = 0;
    b = 0;
    #10 a = 1;
    #10 b = 1;
    #10 a = 0;
    #10 $finish;
end

endmodule
