#!/bin/bash
set -x 
set -e

testground plan import --from ./examples --name examples;
testground run composition -f ./examples/network/ping-pong.ci.toml | tee run.out
./check_result.sh;
