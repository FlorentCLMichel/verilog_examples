`include "4_bit_counter.v"

module four_bit_counter_tb();

// Declare inputs as regs and outputs as wires
reg clock, reset, enable;
wire [3:0] counter_out;

// Initiaize all variables
initial begin
    $display ("time\tclk\treset\tenable\tcounter");
    $monitor ("%g\t%b\t%b\t%b\t%b", 
              $time, clock, reset, enable, counter_out);
    $dumpfile("test.vcd");
    $dumpvars(0, clock, reset, enable, counter_out);
    clock = 1; // initial value of clock
    reset = 0; // initial value of reset
    enable = 0; // initial value of enable
    #5 reset = 1; // Assert the reset
    #10 reset = 0; // De-assert the reset
    #5 enable = 1; // Assert enable
    #100 enable = 1; // De-assert enable
    #10 $finish; // Terminate the simulation
end

// CLock generator
always begin
    #5 clock = ~clock; // Toggle clock every 5 ticks
end

// Connect DUT to test bench
four_bit_counter U_counter(
    clock, 
    reset,
    enable, 
    counter_out
);

endmodule
