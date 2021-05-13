#!/bin/bash -x
env CFLAGS="-O0 -static" \
LIBS="-static" \
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
	    --disable-curl \
	    --enable-heavy-tests \
      --disable-epoll
