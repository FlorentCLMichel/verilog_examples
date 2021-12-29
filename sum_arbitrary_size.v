module add #(parameter N_BITS = 4) (a, b, c);

input [N_BITS-1:0] a, b;
output [N_BITS:0] c;

wire [N_BITS-1:0] a, b, carry, sum, a_and_b, a_or_b, sum_and_carry;
wire [N_BITS:0] c; 

xor (c[0], a[0], b[0]);
and (carry[0], a[0], b[0]);

genvar i;
generate
    for (i=1; i<N_BITS; i=i+1) begin
        xor(sum[i], a[i], b[i]);
        and(a_and_b[i], a[i], b[i]);
        and(sum_and_carry[i], sum[i], carry[i-1]);
        xor(c[i], sum[i], carry[i-1]);
        or(carry[i], a_and_b[i], sum_and_carry[i]);
    end
endgenerate

buf (c[N_BITS], carry[N_BITS-1]);

endmodule


module add_tb();

parameter N_BITS = 8;

reg [N_BITS-1:0] a = 8'b00100011, b = 8'b00010010;
wire [N_BITS:0] c;

add #(N_BITS) A (a, b, c);

initial begin
    #1 $display("a = %h, b = %h, c = %h", a, b, c);
    $finish;
end

endmodule
