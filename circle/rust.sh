#!/bin/bash
set -x 
set -e

testground plan import --from ./sdk-rust --name sdk-rust;
testground run single \
    --plan=sdk-rust \
    --testcase=example \
    --builder=docker:generic \
    --runner=local:docker \
    --instances=1 | tee run.out;
./check_result.sh;
