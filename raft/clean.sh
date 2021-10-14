#if your using centos then enable below command 
#sudo setenforce 0

removeOrdererCA(){

	echo "Removing Orderer CA"
	docker-compose -f ./orderer/ca-orderer.yaml  down -v
	pushd orderer
	docker-compose -f ca-orderer.yaml down -v
	popd

}
removeOrg1CA(){

	echo "Removing Org1 CA"
	docker-compose -f ./org1/ca-org1.yaml down -v
	pushd org1
	docker-compose -f ca-org1.yaml down -v
	popd

}
removeOrg2CA(){

	echo "Removing Org2 CA"
	docker-compose -f ./org2/ca-org2.yaml  down -v
	pushd org2
	docker-compose -f ca-org2.yaml down -v
	popd

}
removeOrderers(){
	echo "Removing orderers "
	docker-compose -f ./orderer/docker-compose-orderer.yaml down -v
	pushd orderer
	docker-compose -f docker-compose-orderer.yaml down -v
	popd
}
removeOrg1(){

	echo "Removing Org1 Peers"
	docker-compose -f ./org1/docker-compose-peer.yaml down -v
	pushd org1
	docker-compose -f docker-compose-peer.yaml down -v
	popd
}
removeOrg2(){
        echo "Removing Org1 Peers"
        docker-compose -f ./org2/docker-compose-peer.yaml down -v
		pushd org2
	docker-compose -f docker-compose-peer.yaml down -v
	popd
}

removeOrdererCA
removeOrg1CA
removeOrg2CA
removeOrderers
removeOrg1
removeOrg2


echo "Removing crypto CA material"
rm -rf ./orderer/fabric-ca
rm -rf ./org1/fabric-ca
rm -rf ./org2/fabric-ca
rm -rf ./orderer/crypto-config-ca
rm -rf ./org1/crypto-config-ca
rm -rf ./org2/crypto-config-ca
rm -rf ./org1/Org1MSPanchors.tx
rm -rf ./org2/Org2MSPanchors.tx
rm -rf ./orderer/genesis.block
rm -rf ./orderer/mychannel.tx
rm -rf ./org1/mychannel.tx
rm -rf ./org1/mychannel.block
rm -rf ./org2/mychannel.tx
rm -rf ./org2/mychannel.block

rm -rf ./deployChaincode/*.tar.gz
rm -rf ./deployChaincode/node_modules
rm -rf ./deployChaincode/log.txt
rm -rf ./deployChaincode/npm-debug.log
docker system prune -a -y
docker volume prune -a -y





sudo rm -rf ./orderer/fabric-ca
sudo rm -rf ./org1/fabric-ca
sudo rm -rf ./org2/fabric-ca
sudo rm -rf ./orderer/crypto-config-ca
sudo rm -rf ./org1/crypto-config-ca
sudo rm -rf ./org2/crypto-config-ca
sudo rm -rf ./org1/Org1MSPanchors.tx
sudo rm -rf ./org2/Org2MSPanchors.tx
sudo rm -rf ./orderer/genesis.block
sudo rm -rf ./orderer/mychannel.tx
sudo rm -rf ./org1/mychannel.tx
sudo rm -rf ./org1/mychannel.block
sudo rm -rf ./org2/mychannel.tx
sudo rm -rf ./org2/mychannel.block

sudo rm -rf ./deployChaincode/*.tar.gz
sudo rm -rf ./deployChaincode/node_modules
sudo rm -rf ./deployChaincode/log.txt
sudo rm -rf ./deployChaincode/npm-debug.log
