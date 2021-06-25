#!/bin/bash 
set -e
set -o pipefail
if [ -z ${DEST} ]; then
  S=$(dirname $(which saphc-c))
  DEST=${S%%/saphc/bin}
fi
echo "install to ${DEST}"

which rsync
if [ $? -ne 0 ]; then
  echo 'rsync is required, but it is not installed.'
  exit 1;
fi
make DEST=${DEST} install
