module secret_number;
parameter secret = 0;
initial begin
    $display("My secret number is %d", secret);
end
endmodule

module defparam_example();
secret_number U0();
defparam U1.secret = 1;
defparam U2.secret = 2;
secret_number U1();
secret_number U2();
secret_number #(3) U3();
secret_number #(.secret(4)) U4();
endmodule
