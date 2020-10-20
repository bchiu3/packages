#!/bin/bash
mypath=$(dirname $(readlink -f $0))

LWS_WOLFSSL_LIBRARIES=$mypath/../build/lib
LWS_WOLFSSL_INCLUDE_DIRS=$mypath/../build/include


mkdir -p ${mypath}/build

