module test_memory();

parameter WORD_SIZE = 6;
parameter MEM_SIZE = 10;

// define the memory
reg [WORD_SIZE-1:0] memory [0:MEM_SIZE-1];
integer unsigned i;
reg [WORD_SIZE-1:0] x;

initial begin

    // read the memory from a file
    $readmemh("memory.list", memory);
    
    // print the memory content
    for (i=0; i<MEM_SIZE; i=i+1) begin
        #1 x = memory[i];
        $display("%h", x);
    end
end

endmodule
