#!/bin/bash
set -x 
set -e

testground plan import --from ./libp2p --name libp2p;
testground run composition -f ./libp2p/ping-interop/_compositions/2-versions.toml | tee run.out
./check_result.sh;
