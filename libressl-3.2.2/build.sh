#!/bin/bash
mypath=$(dirname $(readlink -f $0))
autoreconf -f -i
CFLAGS=-O0 ./configure \
	--prefix=${mypath}/../build \
	--disable-hardening \
	--enable-static \
	--disable-shared \
	--disable-asm
