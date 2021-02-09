#!/bin/bash 
set -e
set -o pipefail
if [ -z ${DEST} ]; then
  S=$(dirname $(which stensal-c))
  DEST=${S%%/stensal/bin}
fi
echo "install to ${DEST}"

make DEST=${DEST} install
