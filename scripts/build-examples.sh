#!/bin/sh

set -e

if ! test -d _examples; then
    mkdir _examples
fi

cd _examples
cmake ..
make
cd ..
