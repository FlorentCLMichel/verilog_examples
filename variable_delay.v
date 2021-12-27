module increment();

reg [3:0] a = 0; 
wire [3:0] b;

assign #(0:3:6) b = a;

initial begin 
    $display("time\ta\tb");
    $monitor("%h\t%h\t%h", $time, a, b);
end

always begin
    #16 a = a + 1;
    if (a == 4'b1111) #16 $finish;
end

endmodule
