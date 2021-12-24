module addbit (
    a, // first input
    b, // second input
    ci, // carry input
    sum, // sum output
    co // carry output
);

// input declaration
input a;
input b;
input ci;

// output declaration
output sum;
output co;

// port data types
wire a;
wire b;
wire ci;
wire sum;
wire co;

// perform the sum
assign {co, sum} = a + b + ci;

endmodule
