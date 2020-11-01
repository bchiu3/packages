#!/bin/bash
mypath=$(dirname $(readlink -f $0))
CFLAGS="-I${mypath}/configs -DMBEDTLS_CONFIG_FILE='<config-mini-tls1_1.h>'" make
DESTDIR=${mypath}/../build make install
