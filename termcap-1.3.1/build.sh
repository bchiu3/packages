#!/bin/bash
mypath=$(dirname $(readlink -f $0))

./configure --prefix=${mypath}/../build
make
make install

