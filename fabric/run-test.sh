git clone https://github.com/hyperledger/caliper-benchmarks.git
cd caliper-benchmarks/
git checkout d02cc8bbc17afda13a0d3af1122d43bfbfc45b0a
npm init -y
npm install --only=prod @hyperledger/caliper-cli@0.4
cd networks/fabric/config_solo_raft/
./generate.sh
cd ../../../
docker pull hyperledger/fabric-ccenv:1.4.4
docker tag hyperledger/fabric-ccenv:1.4.4 hyperledger/fabric-ccenv:latest
npm install --save fabric-client fabric-ca-client
nvm use 12
npm rebuild grpc --force
npx caliper launch manager --caliper-workspace . --caliper-benchconfig benchmarks/samples/fabric/marbles/config.yaml --caliper-networkconfig networks/fabric/v1/v1.4.4/2org1peercouchdb_raft/fabric-go-tls-solo.yaml
cp report.html ../result/
cp caliper.log ../result/
rm -rf caliper-benchmarks/