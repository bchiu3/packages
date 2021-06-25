#!/bin/bash -x
mypath=$(dirname $(readlink -f $0))
mkdir -p $mypath/build
pushd $mypath/build
cmake -DBUILD_SHARED_LIBS=OFF \
	  -DCMAKE_INSTALL_PREFIX=${mypath}/../build \
	  ../
make all install
popd

