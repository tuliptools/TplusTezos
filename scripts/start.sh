#!/usr/bin/env bash

echo "Starting tezos Sandbox script"
echo "   "
echo "Starting Tezos node......"
bash -c "/tezos/src/bin_node/tezos-sandboxed-node.sh 1 --rpc-addr 0.0.0.0:8732 --connections 1 > /tmp/logs 2>&1" &

if test -f "/tezosdata/env"; then
   echo "Skipping client init Script"
   sleep 3
else
    sleep 8
    mkdir /tezosdata
    mkdir /tezosdata/tezclient
    echo "Starting Client init script"
    tezos/src/bin_client/tezos-init-sandboxed-client.sh 1 > /tezosdata/env
fi


echo "Everything ready, Showing Node Output:"
tail -f /tmp/logs
