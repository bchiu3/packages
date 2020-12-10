#!/bin/bash
./autogen.sh
./configure --prefix=$(pwd)/../build
make -j 8
