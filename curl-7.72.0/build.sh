#!/bin/bash -x
export LDFLAGS=-L$(pwd)/../bearssl-0.6/build32 -static
export LIBS=-lbearssl
export CFLAGS=-static
export LT_SYS_LIBRARY_PATH=$(pwd)/../bearssl-0.6/build32
./configure --disable-shared \
			--enable-static \
			--disable-dependency-tracking \
			--disable-ipv6 \
			--disable-ftp \
			--disable-file \
			--disable-ldap \
			--disable-ldaps \
			--disable-rtsp \
			--disable-proxy \
			--disable-dict \
			--disable-telnet \
			--disable-tftp \
			--disable-pop3 \
			--disable-imap \
			--disable-smtp \
			--disable-gopher \
			--disable-sspi \
			--disable-manual \
			--disable-zlib \
			--without-zlib \
			--disable-thread \
			--disable-threaded-resolver \
			--without-ssl \
			--disable-optimize \
			--disable-cookies \
			--disable-crypto-auth \
			--disable-manul \
			--disable-proxy \
			--disable-unix-sockets \
			--disable-doh \
			--without-libidn \
			--without-librtmp \
			--disable-dnsshuffle \
			--with-bearssl=/home/nwang/tmp/bearssl-0.6/build \
			--disable-verbose
make clean
make curl_LDFLAGS=-all-static -j 8
