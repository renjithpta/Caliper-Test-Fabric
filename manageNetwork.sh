#!/bin/bash
RAFT_PATH=${PWD}/raft
MIR_PATH=${PWD}/mir/mir-test-network

if [ $# -eq 0 ]
  then
    echo "No arguments supplied"
fi
if [ "$1" == "mir" ]; then
    cd ${MIR_PATH}
elif [ "$1" == "raft" ]; then
    cd ${RAFT_PATH}
fi

./initialise.sh $2