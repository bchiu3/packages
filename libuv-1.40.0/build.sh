#!/bin/bash
./autogen.sh
./autogen.sh
./configure --prefix=$(pwd)/../build \
			--enable-shared=no \
			--enable-static=yes

make -j 8
make install
