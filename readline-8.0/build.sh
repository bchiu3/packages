#!/bin/bash
mypath=$(dirname $(readlink -f $0))
./configure --enable-static \
			--prefix=${mypath}/../build \
			--libdir=${mypath}/../build/lib \
			--includedir=${mypath}/../build/include
make
make install
