#!/bin/bash 
S=$(dirname $(which stensal-c))
D=${S%%/stensal/bin}
echo "install to $D"

make DEST=$D install
