module print_string();

reg [8*23:0] string;

initial begin
    string = "This is a sample string";
    $display ("%s\n", string);
end

endmodule
