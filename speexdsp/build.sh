#!/bin/bash -x
mypath=$(dirname $(readlink -f $0))
autogen.sh
autogen.sh
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
			--enable-fixed-point

make -j $(nproc) V=1
make install
