module csm #(parameter N_BITS = 4) (out, in); 

output[N_BITS-1:0] out;
input in;

wire in;
wire[N_BITS-1:0] out;
reg[N_BITS-1:0] counter = 0;
reg state = 1;

assign out = counter;

always @(in) begin

    if ((in) && (state)) begin
        counter = counter + 1;
        state = 0;
    end
    
    if (!in) state = 1;

end

endmodule


module csm_tb();

parameter N_BITS = 4;

reg in = 0;
wire[N_BITS-1:0] out;

csm #(N_BITS) C (out, in);

task flip; 
    in = !in;
endtask

initial begin
    $display("time\tin\tout");
    $monitor("%h\t%b\t%h", $time, in, out);
    #1 flip;
    #2 flip;
    #2 flip;
    #3 flip;
    #1 flip;
    #1 flip;
    #1 $finish;
end

endmodule
