#!/usr/bin/env bash


echo "--------------------------------------------------------------"
echo "                                                              "
echo "         ____________________                                 "
echo "        /|   ...    .....''./|   Tezos Sandbox start.sh       "
echo "       / .''' . ''''_ .  ' / |                                "
echo "      /.' ' ____ ' /_/ .  /  /.'.''.                          "
echo "     /'. . \    /. / '   /  / '''''                           "
echo "    /.' . ' \__/' / . .'/  /                                  "
echo "   /.'    ' .  .   '.. /  /                                   "
echo "   |~~~~~~~~~~~~~~~~~~~| /                                    "
echo "   |___________________|/                                     "
echo "   "
echo "   "
echo "   "
echo "   "
echo "Sandbox start script: Starting Tezos node"
bash -c "/tezos/src/bin_node/tezos-sandboxed-node.sh 1 --rpc-addr 0.0.0.0:8732 --connections 1 > /tmp/logs 2>&1" &
sleep 8

if test -f "/tezosdata/env"; then
   echo "Skipping client init Script"
else
    mkdir /tezosdata
    mkdir /tezosdata/tezclient
    echo "Starting Client init script"
    tezos/src/bin_client/tezos-init-sandboxed-client.sh 1 > /tezosdata/env
fi


echo "Everything ready, Showing Node Output:"
tail -f /tmp/logs
