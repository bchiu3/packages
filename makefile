N=$(shell nproc)

DEST ?=

all: build_dir cs50 zlib readline bearssl wolfssl curl
.PHONY: build_dir cs50 bearssl curl zlib sqlite wolfssl

build_dir:
	mkdir -p build/include
	mkdir -p build/lib

cs50:
	make -C cs50
	cp cs50/build/include/cs50.h build/include
	cp cs50/build/lib/libcs50.a  build/lib

bearssl: build_dir
	make -C bearssl-0.6 -j $(N)
	cp bearssl-0.6/build32/libbearssl.a build/lib
	cp bearssl-0.6/build32/libbearssl.so build/lib
	cp bearssl-0.6/inc/* build/include

curl: bearssl
	cd curl-7.72.0 && ./build.sh
	rm -f build/lib/libcurl.la
	rm -rf build/lib/pkgconfig

zlib:
	cd zlib-1.2.11 && ./build.sh

sqlite:
	cd sqlite-3.33.0 && ./build.sh

readline:
	cd readline-8.0 && ./build.sh

wolfssl:
	cd wolfssl-4.5.0-stable && ./build.sh

clean:
	rm -rf build
	make -C cs50 clean
	make -C bearssl-0.6 clean
	if [ -f curl-7.72.0/Makefile ]; then \
		make -C curl-7.72.0 distclean; \
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

install:
	rsync -avz build/include/  $(DEST)/usr/include/
	rsync -avz build/lib/      $(DEST)/usr/lib/
