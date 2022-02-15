// Some simple operations on signed integers
//
// The first bit is the sign (0; positive, 1: negative)
//
// All operations are done modulo 2^n, where n is the number of bits


// addition of two integers
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


// negative of an integer (to check)
module neg #(parameter N_BITS = 4) (a, b);

    input [N_BITS-1:0] a;
    wire [N_BITS-1:0] c, d;
    output [N_BITS-1:0] b;
    
    genvar i;
    generate
        for (i=0; i<N_BITS; i=i+1) begin
            not(c[i], a[i]);
        end
    endgenerate
    
    assign b[0] = a[0];
    assign d[0] = c[0];
    
    genvar j;
    generate
        for (j=1; j<N_BITS; j=j+1) begin
            and(d[j], d[j-1], c[j]);
            xor(b[j], d[j-1], c[j]);
        end
    endgenerate

endmodule


// subtraction of two integers
module sub #(parameter N_BITS = 4) (a, b, c);

    input [N_BITS-1:0] a, b;
    output [N_BITS:0] c;
    
    wire [N_BITS-1:0] a, b, carry, dif, b_and_not_a, dif_and_carry;
    wire [N_BITS:0] c; 
    
    xor (c[0], a[0], b[0]);
    and (carry[0], ~a[0], b[0]);
    
    genvar i;
    generate
        for (i=1; i<N_BITS; i=i+1) begin
            xor(dif[i], a[i], b[i]);
            and(b_and_not_a[i], ~a[i], b[i]);
            and(dif_and_carry[i], ~dif[i], carry[i-1]);
            xor(c[i], dif[i], carry[i-1]);
            or(carry[i], b_and_not_a[i], dif_and_carry[i]);
        end
    endgenerate
    
    buf (c[N_BITS], carry[N_BITS-1]);
     
endmodule


// Fourier transform of size 2
//
// A complex number is represented by 2 integers, with N_BITS bits each for
// the input or N_BITS+1 bits each for the output
module ft2 #(parameter N_BITS = 4) (a, b, c, d);

input [2*N_BITS-1:0] a, b;
output [2*N_BITS+1:0] c, d;

add #(N_BITS) A(a[N_BITS-1:0], b[N_BITS-1:0], c[N_BITS:0]);
add #(N_BITS) B(a[2*N_BITS-1:N_BITS], b[2*N_BITS-1:N_BITS], c[2*N_BITS+1:N_BITS+1]);
sub #(N_BITS) C(a[N_BITS-1:0], b[N_BITS-1:0], d[N_BITS:0]);
sub #(N_BITS) D(a[2*N_BITS-1:N_BITS], b[2*N_BITS-1:N_BITS], d[2*N_BITS+1:N_BITS+1]);

endmodule


// Fourier transform of size 4
//
// A complex number is represented by 2 integers, with N_BITS bits each for
// the input or N_BITS+2 bits each for the output
module ft4 #(parameter N_BITS = 4) (i1, i2, i3, i4, 
                                    o1, o2, o3, o4);

input [2*N_BITS-1:0] i1, i2, i3, i4;
output [2*N_BITS+3:0] o1, o2, o3, o4;

// real part of o1
wire[N_BITS:0] t1;
wire[N_BITS:0] t2;
add #(N_BITS) A1 (i1[2*N_BITS-1:N_BITS], i3[2*N_BITS-1:N_BITS], t1);
add #(N_BITS) A2 (i2[2*N_BITS-1:N_BITS], i4[2*N_BITS-1:N_BITS], t2);
add #(N_BITS+1) A3 (t1, t2, o1[2*N_BITS+3:N_BITS+2]);

// imaginary part of o1
wire[N_BITS:0] t3;
wire[N_BITS:0] t4;
add #(N_BITS) A4 (i1[N_BITS-1:0], i3[N_BITS-1:0], t3);
add #(N_BITS) A5 (i2[N_BITS-1:0], i4[N_BITS-1:0], t4);
add #(N_BITS+1) A6 (t3, t4, o1[N_BITS+1:0]);

// real part of o3
wire[N_BITS:0] t5;
wire[N_BITS:0] t6;
add #(N_BITS) A7 (i1[2*N_BITS-1:N_BITS], i3[2*N_BITS-1:N_BITS], t5);
add #(N_BITS) A8 (i2[2*N_BITS-1:N_BITS], i4[2*N_BITS-1:N_BITS], t6);
sub #(N_BITS+1) S1 (t5, t6, o3[2*N_BITS+3:N_BITS+2]);

// imaginary part of o3
wire[N_BITS:0] t7;
wire[N_BITS:0] t8;
add #(N_BITS) A9 (i1[N_BITS-1:0], i3[N_BITS-1:0], t7);
add #(N_BITS) A10 (i2[N_BITS-1:0], i4[N_BITS-1:0], t8);
sub #(N_BITS+1) S2 (t7, t8, o3[N_BITS+1:0]);

// real part of o2
wire[N_BITS:0] t9;
wire[N_BITS:0] t10;
add #(N_BITS) A11 (i1[2*N_BITS-1:N_BITS], i4[N_BITS-1:0], t9);
add #(N_BITS) A12 (i3[2*N_BITS-1:N_BITS], i2[N_BITS-1:0], t10);
sub #(N_BITS+1) S3 (t9, t10, o2[2*N_BITS+3:N_BITS+2]);

// imaginary part of o2
wire[N_BITS:0] t11;
wire[N_BITS:0] t12;
add #(N_BITS) A13 (i1[N_BITS-1:0], i2[2*N_BITS-1:N_BITS], t11);
add #(N_BITS) A14 (i3[N_BITS-1:0], i4[2*N_BITS-1:N_BITS], t12);
sub #(N_BITS+1) S4 (t11, t12, o2[N_BITS+1:0]);

// real part of o4
wire[N_BITS:0] t13;
wire[N_BITS:0] t14;
add #(N_BITS) A15 (i1[2*N_BITS-1:N_BITS], i2[N_BITS-1:0], t13);
add #(N_BITS) A16 (i3[2*N_BITS-1:N_BITS], i4[N_BITS-1:0], t14);
sub #(N_BITS+1) S5 (t13, t14, o4[2*N_BITS+3:N_BITS+2]);

// imaginary part of o4
wire[N_BITS:0] t15;
wire[N_BITS:0] t16;
add #(N_BITS) A17 (i1[N_BITS-1:0], i4[2*N_BITS-1:N_BITS], t15);
add #(N_BITS) A18 (i3[N_BITS-1:0], i2[2*N_BITS-1:N_BITS], t16);
sub #(N_BITS+1) S6 (t15, t16, o4[N_BITS+1:0]);

endmodule


// test of ft4
module ft4_tb();

parameter N_BITS = 8;

reg [2*N_BITS-1:0] i1 = 16'b0000001100010000;
reg [2*N_BITS-1:0] i2 = 16'b0000000100010000;
reg [2*N_BITS-1:0] i3 = 16'b0000000100010000;
reg [2*N_BITS-1:0] i4 = 16'b0000000100010000;
wire [2*N_BITS+3:0] o1;
wire [2*N_BITS+3:0] o2;
wire [2*N_BITS+3:0] o3;
wire [2*N_BITS+3:0] o4;

ft4 #(N_BITS) F (i1, i2, i3, i4, 
                 o1, o2, o3, o4);

always #1 begin
    i1 = $urandom;
    i2 = $urandom;
    i3 = $urandom;
    i4 = $urandom;
end

initial begin
    $display("input \t\toutput");
    $monitor("(%d,%d)\t(%d,%d)\n(%d,%d)\t(%d,%d)\n(%d,%d)\t(%d,%d)\n(%d,%d)\t(%d,%d)\n", 
             i1[2*N_BITS-1:N_BITS], i1[N_BITS-1:0], 
             o1[2*N_BITS+3:N_BITS+2], o1[N_BITS+1:0], 
             i2[2*N_BITS-1:N_BITS], i2[N_BITS-1:0], 
             o2[2*N_BITS+3:N_BITS+2], o2[N_BITS+1:0], 
             i3[2*N_BITS-1:N_BITS], i3[N_BITS-1:0], 
             o3[2*N_BITS+3:N_BITS+2], o3[N_BITS+1:0], 
             i4[2*N_BITS-1:N_BITS], i4[N_BITS-1:0], 
             o4[2*N_BITS+3:N_BITS+2], o4[N_BITS+1:0]);
    #100 $finish;
end

endmodule
