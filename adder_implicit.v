`include "addbit.v"

module adder_implicit( result, carry, r1, r2, ci );

// Input port declarations
input [3:0] r1;
input [3:0] r2;
input ci;

// Output port declaration
output [3:0] result;
output carry;

// Port wires
wire [3:0] r1;
wire [3:0] r2;
wire ci;
wire [3:0] result;
wire carry;

// Internal variables
wire [1:0] c; 

addbit u0 ( r1[0], r2[0], ci, result[0], c[0] );
addbit u1 ( r1[1], r2[1], c[0], result[1], c[1] );
addbit u2 ( r1[2], r2[2], c[1], result[2], carry );

endmodule
