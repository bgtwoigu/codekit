#!/bin/bash

if [ $# -eq 1 ]; then
#clean exits files
rm default_LNX.LA.3.2* LNX.LA.3.2*

cd ..
find . -name "goso" -prune -o -name "*$1*" -exec ln -s ../{} goso/{} \;

cd goso
else
cat << EOF
Usage: $0 8x26
EOF
fi
