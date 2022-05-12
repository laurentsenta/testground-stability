#!/bin/bash
set -x 
set -e

testground plan import --from ./libp2p --name libp2p;
testground run composition -f ./libp2p/ping/_compositions/simple.ci.toml | tee run.out
./check_result.sh;
