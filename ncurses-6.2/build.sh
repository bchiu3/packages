#!/bin/bash
mypath=$(dirname $(readlink -f $0))
echo $mypath

PREFIX=$mypath/../build

CFLAGS=-g ./configure --prefix=$PREFIX \
			--libdir=$PREFIX/lib \
			--includedir=$PREFIX/include

make -j 8
make install
