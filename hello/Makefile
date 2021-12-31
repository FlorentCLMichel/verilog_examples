hello: build_hello
	vvp hello

alu: build_alu
	vvp alu +a=3 +b=2 +s=0

counter: build_counter
	vvp counter
	gtkwave test.vcd &

build_hello:
	iverilog -o hello hello.v

build_alu:
	iverilog -o alu alu_tb.v alu.v

build_counter:
	iverilog -o counter counter_tb.v counter.v

clean:
	trash hello; trash alu; trash counter; trash test.vcd
