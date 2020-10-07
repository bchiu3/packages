#!/bin/bash
mypath=$(dirname $(readlink) -f $0)

CFLAGS=-O0 ./configure \
	  --prefix=${mypath}/../build \
	  --libdir=${mypath}/../build/lib \
	  --includedir=${mypath}/../build/include \
	  --datadir=${mypath}/../build/docs \
	  --disable-amalgamation
