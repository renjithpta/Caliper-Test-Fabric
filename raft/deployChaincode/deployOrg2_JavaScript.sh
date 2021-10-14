chaincodeInfo()
{
	export CHANNEL_NAME="mychannel"
	export CC_RUNTIME_LANGUAGE="node"
	export CC_VERSION="1"
	export CC_SRC_PATH=../chaincodes
	export CC_NAME="basic"
	export CC_SEQUENCE="1"
	
	export CC_COLL_CONFIG="--collections-config ./collections-config.json"
	export CC_END_POLICY="--signature-policy OR('Org1MSP.peer','Org2MSP.peer')"

}
preSetupJavaScript(){
 
	pushd ../chaincodes
	npm install
	npm run build
	popd

}


export CORE_PEER_TLS_ENABLED=true
export ORDERER_CA=${PWD}/../orderer/crypto-config-ca/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem
export PEER0_ORG2_CA=${PWD}/../org2/crypto-config-ca/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt
export FABRIC_CFG_PATH=${PWD}/../config


setGlobalsForPeer0Org2(){
    export CORE_PEER_LOCALMSPID="Org2MSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_ORG2_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/../org2/crypto-config-ca/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp
    export CORE_PEER_ADDRESS=localhost:9051
}


packageChaincode() {

	  rm -rf ${CC_NAME}.tar.gz

	  peer lifecycle chaincode package ${CC_NAME}.tar.gz --path ${CC_SRC_PATH} --lang ${CC_RUNTIME_LANGUAGE} --label ${CC_NAME}_${CC_VERSION} 

}

installChaincode() {
    
    peer lifecycle chaincode install ${CC_NAME}.tar.gz

}


queryInstalled() {

    peer lifecycle chaincode queryinstalled >&log.txt

    cat log.txt

    PACKAGE_ID=$(sed -n "/${CC_NAME}_${CC_VERSION}/{s/^Package ID: //; s/, Label:.*$//; p;}" log.txt)

    echo PackageID is ${PACKAGE_ID}
}
approveForMyOrg2() {

	setGlobalsForPeer0Org2

 	 peer lifecycle chaincode approveformyorg -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile $ORDERER_CA --channelID $CHANNEL_NAME --name ${CC_NAME} --version ${CC_VERSION} --package-id ${PACKAGE_ID} --sequence ${CC_SEQUENCE} ${CC_END_POLICY} ${CC_COLL_CONFIG}  --init-required


}


insertTransaction(){

	peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA -C $CHANNEL_NAME -n ${CC_NAME} --peerAddresses localhost:9051 --tlsRootCertFiles $PEER0_ORG2_CA -c '{"function": "emptyContract", "Args":[]}' 

	sleep 2
}
readTransaction()
{
         echo "Reading a transaction"
    
	# Query all cars

    	peer chaincode query -C $CHANNEL_NAME -n ${CC_NAME} -c '{"Args":["emptyContract"]}'

    	# Query Car by Id
    	peer chaincode query -C $CHANNEL_NAME -n ${CC_NAME} -c '{"function": "emptyContract","Args":[]}'
}

lifecycleCommands()
{
	packageChaincode
	sleep 2
	installChaincode
	sleep 2
	queryInstalled
	sleep 2
	approveForMyOrg2
	
}
getInstallChaincodes(){

        peer lifecycle chaincode queryinstalled

}
preSetupJavaScript
chaincodeInfo
setGlobalsForPeer0Org2
lifecycleCommands
insertTransaction
readTransaction
getInstallChaincodes
