#!/bin/bash

BKGDIR=/ceph/cms/store/user/jguiang/VBSVHSkim/bkg_1lep_1ak8_2ak4_v1
SIGDIR=/ceph/cms/store/user/jguiang/VBSVHSkim/sig_1lep_1ak8_2ak4_v1

BKGYEARS="20UL16NanoAODv9 \
20UL16NanoAODAPVv9 \
20UL17NanoAODv9 \
20UL18NanoAODv9"

SIGYEARS="20UL16APV_ \
20UL16_ \
20UL17 \
20UL18"

# Desired backgrounds
BKGPROCESSES="DYJETSbkg \
WWdilep \
WWinclusive \
ttdilep"

SIGPROCESSES="VBSOSWWH_C2V_4 \
VBSOSWWH_C2V_3 \
VBSWZH_C2V_3 \
VBSWZH_C2V_4 \
VBSZZH_C2V_4 \
VBSZZH_C2V_3"

#rm -f weightsbkg.txt
#rm -f weightssig.txt
rm -f jobs.txt
mkdir -p logfiles
mkdir -p outputs



for BKGPROCESS in ${BKGPROCESSES}; do
    if [[ ${BKGPROCESS} == *"DYJETSbkg" ]]
    then
        XSECTION=6197900
        KEY="DYJetsToLL_M-50"
    fi
    if [[ ${BKGPROCESS} == *"WWinclusive" ]]
    then
        XSECTION=118710
        KEY="WW_TuneCP5"
    fi
    if [[ ${BKGPROCESS} == *"WWdilep" ]]
    then
        XSECTION=12178
        KEY="WWTo2L2Nu_TuneCP5"
    fi
    if [[ ${BKGPROCESS} == *"ttdilep" ]]
    then
        XSECTION=72100
        KEY="TTTo2L2Nu_TuneCP5"
    fi
    echo ${BKGPROCESS}
    IFILE=0
    for YEAR in ${BKGYEARS}; do
        if [[ ${YEAR} == "20UL16NanoAODv9" ]]; then LUMINOSITY=16.81; fi
        if [[ ${YEAR} == "20UL16NanoAODAPVv9" ]]; then LUMINOSITY=19.52; fi
        if [[ ${YEAR} == "20UL17NanoAODv9" ]]; then LUMINOSITY=41.48; fi
        if [[ ${YEAR} == "20UL18NanoAODv9" ]]; then LUMINOSITY=59.83; fi
        for INPUTDIR in $(ls ${BKGDIR} | grep ${KEY} | grep ${YEAR}); do
            IFILE=$(( IFILE+1 ))
            SUMMEDWGT=$( python3 scale1fb.py -f ${BKGDIR}/${INPUTDIR} )
            SCALE1FB=$( echo "scale=10; ${XSECTION}/${SUMMEDWGT}" | bc )
            #echo ${BKGPROCESS} ${KEY} ${YEAR} ${LUMINOSITY} ${XSECTION} ${SUMMEDWGT} ${SCALE1FB} >> weightsbkg.txt
            echo "./runNanoLooper --input ${BKGDIR}/${INPUTDIR}/ --output outputs/${BKGPROCESS}_${IFILE}.root --scale1fb ${SCALE1FB} --lumi ${LUMINOSITY} > logfiles/${BKGPROCESS}_${IFILE}.log 2>&1" >> .jobs.txt
        done
    done
done


for SIGPROCESS in ${SIGPROCESSES}; do
    echo ${SIGPROCESS}
    if [[ ${SIGPROCESS} == *"VBSOSWWH_C2V_3" ]]
    then
        XSECTION=5.652
        KEY="VBSOSWWH_incl_C2V_3"
    fi
    if [[ ${SIGPROCESS} == *"VBSOSWWH_C2V_4" ]]
    then
        XSECTION=11.8
        KEY="VBSOSWWH_incl_C2V_4"
    fi
    if [[ ${SIGPROCESS} == *"VBSWZH_C2V_3" ]]
    then
        XSECTION=3.742
        KEY="VBSWZH_incl_C2V_3"
    fi
    if [[ ${SIGPROCESS} == *"VBSWZH_C2V_4" ]]
    then
        XSECTION=7.865
        KEY="VBSWZH_incl_C2V_4"
    fi
    if [[ ${SIGPROCESS} == *"VBSZZH_C2V_4" ]]
    then
        XSECTION=6.592
        KEY="VBSZZH_incl_C2V_4"
    fi
    if [[ ${SIGPROCESS} == *"VBSZZH_C2V_3" ]]
    then
        XSECTION=2.994
        KEY="VBSZZH_incl_C2V_3"
    fi
    IFILE=0
    for YEAR in ${SIGYEARS}; do
        if [[ ${YEAR} == "20UL16APV_" ]]; then LUMINOSITY=19.52; fi
        if [[ ${YEAR} == "20UL16_" ]]; then LUMINOSITY=16.81; fi
        if [[ ${YEAR} == "20UL17" ]]; then LUMINOSITY=41.48; fi
        if [[ ${YEAR} == "20UL18" ]]; then LUMINOSITY=59.83; fi
        for INPUTDIR in $(ls ${SIGDIR} | grep ${KEY} | grep ${YEAR}); do
            IFILE=$(( IFILE+1 ))
            SUMMEDWGT=$( python3 scale1fb.py -f ${SIGDIR}/${INPUTDIR} )
            SCALE1FB=$( echo "scale=10; ${XSECTION}/${SUMMEDWGT}" | bc )
            #echo ${SIGPROCESS} ${KEY} ${YEAR} ${XSECTION} ${SUMMEDWGT} ${SCALE1FB} >> weightssig.txt
            echo "./runNanoLooper --input ${SIGDIR}/${INPUTDIR}/ --output outputs/${SIGPROCESS}_${IFILE}.root --scale1fb ${SCALE1FB} --lumi ${LUMINOSITY} > logfiles/${SIGPROCESS}_${IFILE}.log 2>&1" >> .jobs.txt
        done
    done
done


