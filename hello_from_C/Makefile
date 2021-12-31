build_run: build
	vvp -M. -mhello a.out

build: build_c
	iverilog hello.v

build_c: 
	iverilog-vpi hello.c
	trash hello.o

# # Alterbative version
# build_c: 
# 	gcc -c -Wall -fpic -shared hello.c
# 	gcc -shared -o libhello.so hello.o -lvpi
# 	trash hello.o

clean: 
	trash hello.vpi; \
	trash a.out
