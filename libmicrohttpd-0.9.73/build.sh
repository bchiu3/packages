#!/bin/bash -x
env CFLAGS="-O0 -static" \
LDFLAGS="-L/home/nwang/tmp/stensal-standard-2020_09_28/usr/lib" \
LIBS="-static -lbearssl" \
./configure --disable-https \
	    --enable-static \
	    --disable-shared \
	    --disable-gcc-hardening \
	    --disable-sanitizer \
	    --disable-linker-hardening \
	    --disable-nls \
	    --disable-bauth \
	    --disable-dauth \
	    --with-pic=non-PIC \
	    --enable-curl \
	    --enable-heavy-tests \
        --disable-epoll
