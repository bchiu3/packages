N=$(shell nproc)

DEST ?=

all: build_dir cs50 zlib ncurses readline conio
.PHONY: build_dir cs50 ncurses bearssl curl tiny-curl \
	    zlib sqlite wolfssl libressl lws2 lws3 mbedtls openssl uv

ssl: bearssl wolfssl libressl mbedtls termcap openssl

build_dir:
	mkdir -p build/include
	mkdir -p build/lib

cs50:
	make -C cs50
	cp cs50/build/include/cs50.h build/include
	cp cs50/build/lib/libcs50.a  build/lib

ncurses:
	cd ncurses-6.2 && ./build.sh

conio:
	cp conio.h/conio.h build/include

bearssl: build_dir
	make -C bearssl-0.6 -j $(N)
	cp bearssl-0.6/build32/libbearssl.a build/lib
	cp bearssl-0.6/build32/libbearssl.so build/lib
	cp bearssl-0.6/inc/* build/include

curl: bearssl
	cd curl-7.72.0 && ./build.sh
	rm -f build/lib/libcurl.la
	rm -rf build/lib/pkgconfig


tiny-curl: bearssl
	cd tiny-curl-7.72.0 && ./build.sh
	rm -f build/lib/libcurl.la
	rm -rf build/lib/pkgconfig

curl-ws:
	make -C curl-websocket 

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

clean:
	rm -rf build
	make -C cs50 clean
	make -C bearssl-0.6 clean
	make -C curl-websocket clean
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

install:
	rsync -avz build/include/  $(DEST)/usr/include/
	rsync -avz build/lib/      $(DEST)/usr/lib/
