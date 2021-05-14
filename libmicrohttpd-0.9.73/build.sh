#!/bin/bash -x
mypath=$(dirname $(readlink -f $0))
env CFLAGS="-O0" \
LIBS="-static" \
./configure --prefix=$(pwd)/../build \
    --libdir=$(pwd)/../build/lib \
    --includedir=$(pwd)/../build/include \
    --datadir=$(pwd)/../build/docs \
    --datarootdir=$(pwd)/../build/docs \
    --disable-https \
    --enable-static \
    --disable-shared \
    --disable-gcc-hardening \
    --disable-sanitizer \
    --disable-linker-hardening \
    --disable-nls \
    --enable-bauth \
    --enable-dauth \
    --with-pic=non-PIC \
    --disable-curl \
    --enable-heavy-tests \
    --disable-epoll

make -j$(nproc) V=1
make install
