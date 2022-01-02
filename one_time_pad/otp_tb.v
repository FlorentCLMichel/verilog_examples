`include "otp.v"

module otp_tb();

parameter WIDTH = 16;
parameter N_TESTS = 10000;

reg [WIDTH-1:0] message=0, pad=0;
wire [WIDTH-1:0] cipher;
reg [WIDTH-1:0] cipher_from_c=0;
reg clk = 0;

one_time_pad #(WIDTH) otp_i (message, pad, cipher);

initial begin
    $seed_rng; // seed the RNG with the system time
    $display("\nmessage\tpad\tcipher\tcipher (expected)");
    #N_TESTS $display("%0d TESTS PASSED (width: %0d)\n", N_TESTS, WIDTH);
    $finish();
end

// clock
always #1 clk = !clk;

// randomize the message and pad
always @(posedge clk) begin
    $random_from_c(message);
    $random_from_c(pad);
end

// get the result from C
always @(negedge clk) begin
    $otp_c(message, pad, cipher_from_c);
    $display("%h\t%h\t%h\t%h", message, pad, cipher, cipher_from_c);
    if (cipher != cipher_from_c) begin
        $display("TEST FAILED");
        $finish();
    end
end

endmodule
