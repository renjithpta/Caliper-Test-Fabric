#!/bin/bash
RAFT_ID_PATH=${PWD}/raft/org1/crypto-config-ca/peerOrganizations
MIR_ID_PATH=${PWD}/mir/mir-test-network/organizations/peerOrganizations
CALIPER_PATH=${PWD}/caliper/src

cd ${CALIPER_PATH}

if [ $# -eq 0 ]
  then
    echo "No arguments supplied"
    exit 0
fi

rm -r peerOrganizations

if [ "$1" == "mir" ]; then
    cp -r ${MIR_ID_PATH} ./
elif [ "$1" == "raft" ]; then
    cp -r ${RAFT_ID_PATH} ./
fi

./start.sh $1