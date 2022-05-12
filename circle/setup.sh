#!/bin/bash
set -x 
set -e

docker cp `docker create lsenta/testground:edge`:/testground ~/bin/testground
docker pull iptestground/sidecar:edge
docker pull iptestground/sync-service:latest
testground daemon | tee ~/daemon.out
# testground healthcheck --runner local:docker --fix