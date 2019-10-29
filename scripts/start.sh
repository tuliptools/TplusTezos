#!/usr/bin/env bash

DATA_DIR=/tezosdata
export DATA_DIR=/tezosdata
echo "Starting tezos Sandbox script"
echo "   "
if test -f "/tezosdata/env"; then
   echo "Skipping client init Script"
else
   cp -r /sandoxpre/* /tezosdata/
fi
echo "   "
echo "Starting Tezos node......"
bash -c "/tezos/src/bin_node/tezos-sandboxed-node.sh 1 --rpc-addr 0.0.0.0:8732 --connections 1 > /tmp/logs 2>&1" &

sleep 5

echo "Everything ready, Showing Node Output:"
tail -f /tmp/logs
