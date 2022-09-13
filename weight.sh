#!/bin/bash

BKGDIR=/ceph/cms/store/user/jguiang/VBSVHSkim/bkg_1lep_1ak8_2ak4_v1
SIGDIR=/ceph/cms/store/user/jguiang/VBSVHSkim/sig_1lep_1ak8_2ak4_v1

rm -f weights.txt

for DIR in $( ls $SIGDIR )
do
    DIRPATH=${SIGDIR}/${DIR}
    echo In $DIRPATH
    echo ${DIR} >> weights.txt
    python3 scale1fb.py -f ${DIRPATH} >> weights.txt
done

