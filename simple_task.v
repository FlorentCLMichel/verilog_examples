module simple_task();

parameter N_BITS = 8;

task reverse;
    input [N_BITS-1:0] in;
    output [N_BITS-1:0] out;
    begin
        integer i;
        for (i=0; i<N_BITS; i=i+1) begin
            out[i] = in[N_BITS-i-1];
        end
    end
endtask

reg [N_BITS-1:0] original;
reg [N_BITS-1:0] reversed;

always @ (original) reverse(original, reversed);

initial begin
    $display("original\treversed");
    $monitor("%b\t%b", original, reversed);
    #1 original = 8'b00000000;
    #1 original = 8'b01010101;
    #1 original = 8'b11110000;
    #1 original = 8'b11001100;
end

endmodule
