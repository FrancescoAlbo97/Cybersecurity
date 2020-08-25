#!/bin/bash
if [ -z $1 ] || [ ! -f $1 ]; then
  echo "Please provide a valid script file to execute as the first parameter (i.e. private_contract.js)" >&2
  exit 1
fi
BIN_GETH=/home/alessio/.quorum-wizard/bin/quorum/2.7.0/geth

$BIN_GETH --exec "loadScript(\"$1\")" attach qdata/dd1/geth.ipc
