#!/bin/bash
mypath=$(dirname $(readlink -f $0))

mkdir -p ${mypath}/build

cd ${mypath}/build

cmake -G"Unix Makefiles" \
  -DLWS_WITH_ZLIB= 1 \
  -DLWS_WITH_SSL=1 \
  -DLWS_WITH_MBEDTLS=1 \
  -DLWS_WITHOUT_EXTENSIONS=1 \
  -DLWS_WITH_ZIP_FOPS=0 \
  -DLWS_MBEDTLS_LIBRARIES="$mypath/../build/lib/libmbedtls.a;$mypath/../build/lib/libmbedx509.a;$mypath/../build/lib/libmbedcrypto.a" \
  -DLWS_MBEDTLS_INCLUDE_DIRS=$mypath/../build/include \
  -DCMAKE_C_COMPILER=$CC \
  -DCMAKE_C_FLAGS="-fno-stack-protector -fno-PIC -Wno-error" \
  -DCMAKE_INSTALL_PREFIX=$mypath/../build \
  ..

make
