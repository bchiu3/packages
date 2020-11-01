#!/bin/bash
CFLAGS="-I$PWD/configs -DMBEDTLS_CONFIG_FILE='<config-mini-tls1_1.h>'" make
DESTDIR=$PWD/../build make install
