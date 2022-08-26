#!/bin/bash

SAMPLEDIR=$HOME/VVHStudies

rm -f weights.txt

for DIR in $( ls $SAMPLEDIR )
do
    DIRPATH=${SAMPLEDIR}/${DIR}
    echo In $DIRPATH
    echo ${DIR} >> weights.txt
    python3 scale1fb.py -f ${DIRPATH} >> weights.txt
done

