full: build run clean

build: build_c 
	iverilog -g2012 otp_tb.v

build_c: 
	iverilog-vpi otp.c
	trash otp.o

run: a.out
	vvp -M. -motp a.out

clean: 
	trash a.out; \
    trash otp.vpi
