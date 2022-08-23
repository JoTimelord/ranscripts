#!/bin/bash

SAMPLEDIR="/ceph/cms/store/user/jguiang/VBSVHSkim/sig_1lep_1ak8_2ak4_v1"

PROCESSES="VBSWWH \
VBSOSWWH \
VBSZZH \
VBSWZH"

DESTDIR=${HOME}/VBSVVHSignals

recreate () {
    if [ -d $1 ]
    then
        echo Directory $1 already exists
        echo Attempting to remove it
        rm -r $DESTDIR
        echo "Successfully removed the directory"
    fi
    mkdir $1
}

recreate $DESTDIR

for PROCESS in ${PROCESSES}
do
    for VAL in {3,4}
    do
        FILENAME=${PROCESS}_C2V_${VAL}
        DIRNAME=${DESTDIR}/${PROCESS}_C2V_${VAL}
        recreate $DIRNAME
        cp -v -r ${SAMPLEDIR}/*_${PROCESS}_*_C2V_${VAL}* ${DESTDIR}/${PROCESS}_C2V_${VAL}/
    done
done

for VAL in {3,4}
do
    for PROCESS in ${PROCESSES}
    do
        DIR1=${DESTDIR}/${PROCESS}_C2V_${VAL}
        NUM=0
        for FILE in $( ls $DIR1/*/*.root )
        do
            mv -v $FILE $DIR1/output${NUM}.root
            (( NUM++ ))
        done
    done
done






