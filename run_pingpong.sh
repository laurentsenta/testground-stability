#!/usr/bin/env bash
set -x
set -e

testground healthcheck --runner local:docker --fix;
testground plan import --from ./examples --name examples;
testground run composition -f ./examples/network/ping-pong.ci.toml | tee run.out;
