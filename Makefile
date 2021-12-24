build_run: build
	vvp ./a.out

build: 
	iverilog ${file}

run:
	vvp ${file}

clean: 
	trash a.out; \
	trash test.vcd
