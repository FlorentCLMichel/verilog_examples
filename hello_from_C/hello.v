module hello_pli ();
    
reg [3:0] x = 4'b0010;
reg [3:0] y = 4'b0011;
reg [3:0] z = 4'b0000;

initial begin
    $display("Initial values: %b, %b, %b", x, y, z);
    #1 $hello(x, y, z);
    #1 $display("Sum: %b", z);
    #1 $finish;
end

endmodule
