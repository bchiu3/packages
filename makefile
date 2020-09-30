N=$(shell nproc)

all: build_dir cs50 bearssl curl
.PHONY: build_dir cs50 bearssl curl

build_dir:
	mkdir -p build/include
	mkdir -p build/lib

cs50:
	make -C cs50 -j $(N)
	cp cs50/build/include/cs50.h build/include
	cp cs50/lib/libcs50.a  build/lib

bearssl: build_dir
	make -C bearssl-0.6 -j $(N)
	cp bearssl-0.6/build32/libbearssl.a build/lib
	cp bearssl-0.6/inc/* build/include

curl: bearssl
	cd curl-7.72.0 && ./build.sh


clean:
	rm -rf build
	make -C cs50 clean
	make -C bearssl-0.6 clean
	if [ -f curl-7.72.0/Makefile ]; then \
		make -C curl-7.72.0 distclean; \
	fi
