#!/usr/bin/env bash
set -x
set -e

testground healthcheck --runner local:docker --fix;
testground plan import --from ./libp2p --name libp2p;
testground run composition -f ./libp2p/ping/_compositions/simple.ci.toml | tee run.out;

