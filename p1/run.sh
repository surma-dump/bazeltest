#!/bin/bash

set -e -o pipefail

tree -l > $1/tree.txt
env > $1/env.txt
echo \$\< = $2 >> $1/env.txt
echo location run.sh = $3 >> $1/env.txt
echo \$RULEDIR = $1 >> $1/env.txt
