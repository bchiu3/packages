N=$(shell nproc)

CC ?= gcc
DEST ?=

all: build_dir zlib ncurses readline conio 
.PHONY: build_dir 

ssl: bearssl wolfssl libressl mbedtls termcap openssl

build_dir:
	mkdir -p build/include
	mkdir -p build/lib

ncurses:
	cd ncurses-6.2 && ./build.sh

conio:
	cp conio.h/conio.h build/include

bearssl: build_dir
	make -C bearssl-0.6x -j $(N)
	cp bearssl-0.6x/build/libbearssl.a build/lib
	cp bearssl-0.6x/inc/* build/include

bearssl6: build_dir
	make -C bearssl-0.6x -j $(N)
	cp bearssl-0.6x/build/libbearssl.a build/lib
	cp bearssl-0.6x/inc/* build/include


curl: 
	cd curl-7.72.0 && ./build.sh
	rm -f build/lib/libcurl.la
	rm -rf build/lib/pkgconfig


tiny-curl: 
	cd tiny-curl-7.72.0 && ./build.sh
	rm -f build/lib/libcurl.la
	rm -rf build/lib/pkgconfig

curl-ws:
	make -C curl-websocket

pcre:
	cd pcre2-10.36 && ./build.sh
	rm -rf build/lib/libpcre2-*.la
	rm -rf build/lib/pkgconfig

zlib:
	cd zlib-1.2.11 && ./build.sh

sqlite:
	cd sqlite-3.33.0 && ./build.sh

readline:
	cd readline-8.0 && ./build.sh

wolfssl:
	cd wolfssl-4.5.0-stable && ./build.sh

lws2:
	cd libwebsockets-2.4.2 && ./build.sh

lws3:
	cd libwebsockets-3.2.2 && ./build.sh

openssl:
	cd openssl-1.1.1i && ./build.sh

libressl:
	cd libressl-3.2.2 && ./build.sh

mbedtls:
	cd mbedtls-2.24.0 && ./build.sh

termcap:
	cd termcap-1.3.1 && ./build.sh

uv:
	cd libuv-1.40.0 && ./build.sh

kcgi:
	cd kcgi-0.12.3 && ./build.sh

mhd:
	cd libmicrohttpd-0.9.73 && ./build.sh

opus:
	cd opus-1.3.1 && ./build.sh

sodium:
	cd libsodium-1.0.18 && ./build.sh

clean:
	rm -rf build
	make -C bearssl-0.6 clean
	make -C bearssl-0.6x clean
	make -C curl-websocket clean
	make -C mbedtls-2.24.0 clean
	if [ -f curl-7.72.0/Makefile ]; then \
		make -C curl-7.72.0 distclean; \
	fi
	if [ -f tiny-curl-7.72.0/Makefile ]; then \
		make -C tiny-curl-7.72.0 distclean; \
	fi
	make -C zlib-1.2.11 distclean
	if [ -f sqlite-3.33.0/Makefile ]; then \
		make -C sqlite-3.33.0 distclean; \
	fi
	if [ -f readline-8.0/Makefile ]; then \
		make -C readline-8.0 distclean; \
	fi
	if [ -f wolfssl-4.5.0/Makefile ]; then \
		make -C wolfssl-4.5.0 distclean; \
	fi
	if [ -f ncurses-6.2/Makefile ]; then \
		make -C ncurses-6.2 distclean; \
	fi
	if [ -f libressl-3.2.2/Makefile ]; then \
		make -C libressl-3.2.2 distclean; \
	fi
	if [ -f openssl-1.1.1i/Makefile ]; then \
		make -C openssl-1.1.1i distclean; \
	fi
	if [ -f libuv-1.40.0/Makefile ]; then \
		make -C libuv-1.40.0 distclean; \
	fi
	cd libwebsockets-2.4.2 && rm -rf build
	cd libwebsockets-3.2.2 && rm -rf build
	if [ -f opus-1.3.1/Makefile ]; then \
		make -C opus-1.3.1 distclean; \
	fi
	if [ -f libsodium-1.0.18/Makefile ]; then \
		make -C libsodium-1.0.18 distclean; \
	fi
	#bmake -C kcgi-0.12.3 distclean;
	if [ -f pcre2-10.36/Makefile ]; then \
		make -C pcre2-10.36 distclean; \
	fi
	if [ -f libmicrohttpd-0.9.73/Makefile ]; then \
		make -C libmicrohttpd-0.9.73 distclean; \
	fi

install:
	# remove all shared libraries
	rm build/lib/*.so*
	rsync -avz build/include/  $(DEST)/usr/include/
	rsync -avz build/lib/      $(DEST)/usr/lib/
