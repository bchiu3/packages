#!/bin/bash -x
mypath=$(dirname $(readlink -f $0))
export LDFLAGS=-L$(mypath)/../build/lib -static
export CFLAGS=-O0
./configure --prefix=$(pwd)/../build \
			--libdir=$(pwd)/../build/lib \
			--includedir=$(pwd)/../build/include \
			--datadir=$(pwd)/../build/docs \
			--datarootdir=$(pwd)/../build/docs \
			--disable-shared \
			--enable-static \
			--disable-dependency-tracking \
			--enable-pcre2-16 \
			--enable-pcre2-32 \
			--disable-valgrind \
			--with-pic=non-PIC
			


make -j $(nproc) V=1
make install
