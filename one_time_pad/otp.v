module one_time_pad 
    #(parameter WIDTH=8)
    (input wire [WIDTH-1:0] message, 
     input wire [WIDTH-1:0] pad, 
     output wire [WIDTH-1:0] cipher);

assign cipher = message ^ pad;

endmodule
