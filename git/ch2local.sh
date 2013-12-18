#!/bin/bash
if [ $# -eq 2 ]; then
sed 's/git:\/\/codeaurora\.org/git@192\.168\.180\.185\:\/code\/gb\/qct/' $1 >tmp1.xml
sed 's/codeaurora\.org//' tmp1.xml > $2
head $2

else
cat << EOF
Usage: $0 input.xml output.xml
EOF
fi
