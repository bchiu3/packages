#!/bin/bash -x
mypath=$(dirname $(readlink -f $0))
./autogen.sh
./configure --prefix=$(pwd)/../build \
			--libdir=$(pwd)/../build/lib \
			--include=$(pwd)/../build/include \
			--enable-static=yes \
			--enable-shared=yes \
			--enable-debug=yes \
			--enable-asm=no \
			--enable-opensslextra=yes \
			--enable-harden=no \
			--enable-sha512 \
			--enable-singlethreaded=yes

make -j 8
make install
