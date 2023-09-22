#!/bin/bash

set -e -o pipefail

cd $1
cat > code.json << EOF
{
	"hello": "world"
}
EOF

echo @ = $@ > lol.txt
echo OUTS = $OUTS >> lol.txt
echo PATH = $PATH >> lol.txt
echo PWD = $PWD >> lol.txt
echo TMPDIR = $TMPDIR >> lol.txt
