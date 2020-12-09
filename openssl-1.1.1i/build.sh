#!/bin/bash
#./Configure no-threads no-shared no-asm 386 --prefix=$(pwd)/../build linux-generic32

./config --prefix=$(pwd)/../build --debug no-asm no-pic no-shared no-threads
