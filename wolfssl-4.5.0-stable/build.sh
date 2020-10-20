#!/bin/bash -x
mypath=$(dirname $(readlink -f $0))
./autogen.sh
./configure --prefix=$(pwd)/../build \
			--libdir=$(pwd)/../build/lib \
			--include=$(pwd)/../build/include \
			--enable-static=yes \
			--enable-shared=yes \
			--enable-debug=yes \
			--enable-asm=no
make -j 8
make install
