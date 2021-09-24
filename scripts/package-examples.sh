#!/bin/bash

#
# Script to build a tarball of all examples from Qt6 Book
# 
# Moves the docs/CHAPTER/src/EXAMPLE into a qt6book/CHAPTER/EXAMPLE structure
#

set -e

tmpdir=$(mktemp -d)
mkdir -p $tmpdir/qt6book

for exdir in docs/*/src; do
    chname=$(echo $exdir | sed 's/^docs\///;s/\/src$//;')
    mkdir -p "$tmpdir/qt6book/$chname"
    
    cd docs/$chname/src
    for exexdir in *; do
        # Skip build- dirs (created by Qt Creator)
        if [[ $exexdir == build-* ]]; then
            echo "Skipping $exexdir in $chname"
            continue
        fi
        # Skip screenshots.qml file
        if [[ $exexdir == "screenshots.qml" ]]; then
            echo "Skipping $exexdir in $chname"
            continue
        fi
        
        tar cf - --exclude=*.qsb $exexdir | (cd $tmpdir/qt6book/$chname; tar xfp -)
    done
    cd ../../..
done

# Create a resulting examples.tar.gz file where vuepress places the built site and at $(pwd)
destdir=$(pwd)
(cd $tmpdir; tar cvfz $destdir/examples.tar.gz qt6book/ > /dev/null)
cp examples.tar.gz docs/.vuepress/dist/

# Clean up the temporary directory
rm -rf $tmpdir
