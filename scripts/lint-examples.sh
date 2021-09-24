#!/bin/bash

#
# Script to run qmllint on all example qml files
#

for f in $(find docs/ -name *.qml)
do 
    qmllint $f
done
