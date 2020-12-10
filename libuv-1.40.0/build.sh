#!/bin/bash
./autogen.sh
./autogen.sh
./configure --prefix=$(pwd)/../build
make -j 8
make install
