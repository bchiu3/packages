#!/bin/bash
mypath=$(dirname $(readlink -f $0))
CFLAGS=-O0 ./configure \
	  --prefix=${mypath}/../build \
	  --includedir=${mypath}/../build/include \
	  --libdir=${mypath}/../build/lib \
	  -static
