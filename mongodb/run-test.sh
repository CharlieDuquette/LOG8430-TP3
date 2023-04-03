docker-compose -f ./docker-compose.yml up -d
docker exec -it primary mongosh --eval "rs.initiate({
 _id: \"myReplicaSet\",
 members: [
   {_id: 0, host: \"192.168.5.2:27017\"},
   {_id: 1, host: \"192.168.5.3:27017\"},
   {_id: 2, host: \"192.168.5.4:27017\"},
   {_id: 3, host: \"192.168.5.5:27017\"},
   {_id: 4, host: \"192.168.5.6:27017\"}
 ]
})"
curl -O --location https://github.com/brianfrankcooper/YCSB/releases/download/0.5.0/ycsb-0.5.0.tar.gz
tar xfvz ycsb-0.5.0.tar.gz
cd ycsb-0.5.0
./bin/ycsb load mongodb-async -s -P workloads/workloadd -p mongodb.url=mongodb://192.168.5.2:27017/ycsb?w=0 > ../result/outputLoadAsync.txt
./bin/ycsb run mongodb-async -s -P workloads/workloadd -p mongodb.url=mongodb://192.168.5.2:27017/ycsb?w=0 > ../result/outputRunAsync.txt
cd ../
docker-compose -f ./docker-compose.yml down -v
rm -rf ycsb-0.5.0/ ycsb-0.5.0.tar.gz 