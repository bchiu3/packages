#!/bin/bash -x
export LDFLAGS=-L$(pwd)/../build/lib -static
export CFLAGS=-static
export LT_SYS_LIBRARY_PATH=$(pwd)/../build/lib
./configure --prefix=$(pwd)/../build \
			--libdir=$(pwd)/../build/lib \
			--includedir=$(pwd)/../build/include \
			--datadir=$(pwd)/../build/docs \
			--datarootdir=$(pwd)/../build/docs \
			--disable-shared \
			--enable-static \
			--disable-ssp \
			--disable-asm \
			--disable-pie \
			--disable-soname-versions \
			--enable-minimal

make V=1
make install
