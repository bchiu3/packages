#!/bin/bash 
set -e
set -o pipefail
if [ -z ${DEST} ]; then
  S=$(dirname $(which stensal-c))
  DEST=${S%%/stensal/bin}
fi
echo "install to ${DEST}"

error=""
for i in rsync; do
  ##echo "$i"
  command -v $i
  if [ "$?" -ne 0 ]; then
    echo "cannot find $i"
    case $i in
      *)
        error="$error $i"
		;;
    esac
  fi
done

if [ ! "$error" = "" ]; then
  echo "For Debian and Ubuntu, please run the following command:"
  echo " sudo apt-get update && sudo apt-get install -y $error"
  echo "For Other Linux, please refer your distro's installation command"
  exit 1;
fi

make DEST=${DEST} install
