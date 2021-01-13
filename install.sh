#!/bin/bash 
if [ -z ${DEST} ]; then
  S=$(dirname $(which stensal-c))
  D=${S%%/stensal/bin}
fi
echo "install to ${DEST}"

make DEST=${DEST} install
