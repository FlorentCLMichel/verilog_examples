build_run: build
	vvp a.out

build: 
	iverilog -g2012 ${file}

run:
	vvp ${file}

clean: 
	trash a.out; \
	trash test.vcd
