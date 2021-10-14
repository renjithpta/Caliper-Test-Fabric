export PATH=${PWD}/bin:$PATH
if [ "$1" == "up" ]; then
    cd org1
    ./1_enrollOrg1AdminAndUsers.sh
    sleep 2
    ./2_generateMSPOrg1.sh 

    sleep 2
    cd ../org2
    ./1_enrollOrg2AdminAndUsers.sh
    sleep 2
    ./2_generateMSPOrg2.sh 
    sleep 2
    cd ../orderer
    ./1_enrollAdminAndMSP.sh
    sleep 3
    ./2_artifact.sh
    sleep 3
    cd ../org1
    ./3_createChannel.sh
    sleep 5
    cd ../org2
    ./3_joinChannel.sh

    sleep 2
    pushd ../deployChaincode

    ./deployOrg1_JavaScript.sh
    sleep 2
    ./deployOrg2_JavaScript.sh

    popd


    cd ../org1

    sudo chmod +rwx */**
    sudo chmod +rwx .

    sudo chmod +rwx */**/**
    for KEY in $(find crypto-config-ca -type f -name "*_sk"); do
        KEY_DIR=$(dirname ${KEY})
        sudo mv ${KEY} ${KEY_DIR}/priv_sk
    done


    cd ../org2
    sudo chmod +rwx */**
    sudo chmod +rwx .
    for KEY in $(find crypto-config-ca -type f -name "*_sk"); do
        KEY_DIR=$(dirname ${KEY})
        sudo mv ${KEY} ${KEY_DIR}/priv_sk
    done

    cd ..
    rm -rf connection-org1.json
    ./org1/ccp-generate.sh
    cp ./org1/connection-org1.json ./org1/crypto-config-ca/peerOrganizations/org1.example.com

elif [ "$1" == "down" ]; then
    ./clean.sh
fi

