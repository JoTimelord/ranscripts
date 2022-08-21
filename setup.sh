#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Setting up ROOT"

source /cvmfs/cms.cern.ch/cmsset_default.sh

alias cmssw1068='cwd=${PWD}; cd /cvmfs/cms.cern.ch/slc7_amd64_gcc700/cms/cmssw/CMSSW_10_6_8/src; cmsenv; cd $cwd; echo Now using CMSSW v10.6.8'
alias cmssw1134='cwd=${PWD}; cd /cvmfs/cms.cern.ch/slc7_amd64_gcc900/cms/cmssw/CMSSW_11_3_4/src; cmsenv; cd $cwd; echo Now using CMSSW v11.3.4'
alias cmssw1220='cwd=${PWD}; cd /cvmfs/cms.cern.ch/slc7_amd64_gcc900/cms/cmssw/CMSSW_12_2_0/src; cmsenv; cd $cwd; echo Now using CMSSW v12.2.0'
alias cmssw1221pre4='cwd=${PWD}; cd /cvmfs/cms.cern.ch/slc7_amd64_gcc900/cms/cmssw/CMSSW_12_1_0_pre4_ROOT624/src; cmsenv; cd $cwd; echo Now using CMSSW v12.2.1 (pre4, ROOT 6.24)'

cmssw1220

