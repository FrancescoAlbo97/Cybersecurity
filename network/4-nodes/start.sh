#!/bin/bash
echo "
Starting Quorum network...
"
BIN_GETH=/home/alessio/.quorum-wizard/bin/quorum/2.7.0/geth



echo "Starting Quorum nodes"
PRIVATE_CONFIG=ignore nohup $BIN_GETH --datadir qdata/dd1 --nodiscover --rpc --rpccorsdomain=* --rpcvhosts=* --rpcaddr 0.0.0.0 --rpcapi admin,db,eth,debug,miner,net,shh,txpool,personal,web3,quorum,istanbul,quorumPermission --ws --wsaddr 0.0.0.0 --wsorigins=* --emitcheckpoints --unlock 0 --password qdata/dd1/keystore/password.txt --allow-insecure-unlock --graphql --graphql.port 24000 --graphql.corsdomain=* --graphql.addr 0.0.0.0 --istanbul.blockperiod 5 --syncmode full --mine --minerthreads 1 --permissioned --verbosity 5 --networkid 10 --rpcport 22000 --wsport 23000 --port 21000 2>>qdata/logs/1.log &
PRIVATE_CONFIG=ignore nohup $BIN_GETH --datadir qdata/dd2 --nodiscover --rpc --rpccorsdomain=* --rpcvhosts=* --rpcaddr 0.0.0.0 --rpcapi admin,db,eth,debug,miner,net,shh,txpool,personal,web3,quorum,istanbul,quorumPermission --ws --wsaddr 0.0.0.0 --wsorigins=* --emitcheckpoints --unlock 0 --password qdata/dd2/keystore/password.txt --allow-insecure-unlock --graphql --graphql.port 24001 --graphql.corsdomain=* --graphql.addr 0.0.0.0 --istanbul.blockperiod 5 --syncmode full --mine --minerthreads 1 --permissioned --verbosity 5 --networkid 10 --rpcport 22001 --wsport 23001 --port 21001 2>>qdata/logs/2.log &
PRIVATE_CONFIG=ignore nohup $BIN_GETH --datadir qdata/dd3 --nodiscover --rpc --rpccorsdomain=* --rpcvhosts=* --rpcaddr 0.0.0.0 --rpcapi admin,db,eth,debug,miner,net,shh,txpool,personal,web3,quorum,istanbul,quorumPermission --ws --wsaddr 0.0.0.0 --wsorigins=* --emitcheckpoints --unlock 0 --password qdata/dd3/keystore/password.txt --allow-insecure-unlock --graphql --graphql.port 24002 --graphql.corsdomain=* --graphql.addr 0.0.0.0 --istanbul.blockperiod 5 --syncmode full --mine --minerthreads 1 --permissioned --verbosity 5 --networkid 10 --rpcport 22002 --wsport 23002 --port 21002 2>>qdata/logs/3.log &
PRIVATE_CONFIG=ignore nohup $BIN_GETH --datadir qdata/dd4 --nodiscover --rpc --rpccorsdomain=* --rpcvhosts=* --rpcaddr 0.0.0.0 --rpcapi admin,db,eth,debug,miner,net,shh,txpool,personal,web3,quorum,istanbul,quorumPermission --ws --wsaddr 0.0.0.0 --wsorigins=* --emitcheckpoints --unlock 0 --password qdata/dd4/keystore/password.txt --allow-insecure-unlock --graphql --graphql.port 24003 --graphql.corsdomain=* --graphql.addr 0.0.0.0 --istanbul.blockperiod 5 --syncmode full --mine --minerthreads 1 --permissioned --verbosity 5 --networkid 10 --rpcport 22003 --wsport 23003 --port 21003 2>>qdata/logs/4.log &

echo "Successfully started Quorum network."
echo ""