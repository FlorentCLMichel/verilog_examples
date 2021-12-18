build_run: build
	vvp ./a.out
	trash ./a.out

build: 
	iverilog ${file}

run:
	vvp ${file}

clean: 
	trash a.out
