// This is a 4-bits up-counter with synchronous active high reset and active
// high enable signal.

module four_bit_counter(
    clock, 
    reset, // active high, synchronous Reset
    enable, // active high, enable signal
    counter_out // 4-bit vector output
);

// Input ports

input clock;
input reset;
input enable;

// Output ports
output [3:0] counter_out;

// Input ports data type (wires)
wire clock;
wire reset;
wire enable;

// Output port data type (storage element)
reg [3:0] counter_out;

// Trigger the block below on a positive edge of the clock
always @ (posedge clock)
begin: COUNTER

    // If reset is active, we load counter_out with 4'b0000
    if (reset == 1'b1) begin
        counter_out <= #1 4'b0000;
    end

    // If enable is active, we increment the counter
    if (enable == 1'b1) begin
        counter_out <= #1 counter_out + 1;
    end

end

endmodule
