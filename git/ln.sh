#!/bin/sh

if [ $# -eq 1 ]; then
CKROOT=/opt/duxd/codekit
GOSO_MANIFEST=LINUX/android/.repo/manifests/goso

for f in cp2goso.sh ch2local.sh remove-unused.sh; do
rm -f $1/$GOSO_MANIFEST/$f
ln -s $CKROOT/git/$f $1/$GOSO_MANIFEST/$f
done

else
cat << EOF
Usage: $0 local-repo
EOF

fi
