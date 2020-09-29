all: build_dir cs50 bearssl curl

build_dir:
	mkdir -p build/include
	mkdir -p build/lib

cs50:
	make -C cs50
	cp cs50/build/include/cs50.h build/include
	cp cs50/lib/libcs50.a  build/lib

bearssl:
	make -C bearssl-0.6

curl:
	./curl-7.72.0/build.sh


clean:
	rm -rf build
	make -C cs50 clean
	make -C bearssl-0.6 clean
	make -C curl-7.72.0 distclean
