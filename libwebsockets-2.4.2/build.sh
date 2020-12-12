#!/bin/bash
mypath=$(dirname $(readlink -f $0))

mkdir -p ${mypath}/build

cd ${mypath}/build

cmake -G"Unix Makefiles" \
  -DLWS_WITH_ZLIB= 1 \
  -DLWS_WITH_SSL=1 \
  -DLWS_WITH_WOLFSSL=1 \
  -DLWS_WITHOUT_EXTENSIONS=1 \
  -DLWS_WITH_ZIP_FOPS=0 \
  -DLWS_WOLFSSL_LIBRARIES=$mypath/../build/lib/libwolfssl.a \
  -DLWS_WOLFSSL_INCLUDE_DIRS=$mypath/../build/include \
  -DCMAKE_C_COMPILER=$CC \
  -DCMAKE_C_FLAGS="-fno-stack-protector -fPIC -Wno-error" \
  -DLWS_WITHOUT_TESTAPPS=1 \
  -DCMAKE_INSTALL_PREFIX=$mypath/../build \
  -DLWS_WITH_SHARED=0 \
  ..

make
make install
