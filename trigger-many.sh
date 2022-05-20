#!/usr/bin/env bash
set -x
# set -e


function lazy() {
    # lazy version
    git checkout -b trigger-many;

    for i in {1..50}; do
        echo $i;
        # trigger workflow
        touch $i.txt;
        git add $i.txt;
        git commit -m"$i";
        git push origin trigger-many:trigger-many;
        sleep 10;
    done;
}

function fancy() {
    for i in {1..30}; do
        echo $i;
        FAILED=true;

        while [ $FAILED = true ]; do
            gh api repos/laurentsenta/testground-stability/actions/runs/2309077999/rerun -X POST;

            if [ $? -ne 0 ]; then
                FAILED=true
                sleep 20;
            else
                FAILED=false;
            fi
        done;
    done
}

lazy;