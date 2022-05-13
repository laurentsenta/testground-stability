#!/usr/bin/env bash
set -x
set -e

RUN_IDS=$(gh api repos/laurentsenta/testground-stability/actions/runs --paginate --jq '.workflow_runs[] | .id')

echo > output.json

echo "[" >> output.json

for RUN_ID in $RUN_IDS; do
    echo $RUN_ID;
    # https://stackoverflow.com/questions/69299283/how-to-get-list-of-previous-job-runs-from-github-actions
    gh api "repos/laurentsenta/testground-stability/actions/runs/${RUN_ID}/jobs" --jq '.jobs[] | { run_id, id, name, status, conclusion, started_at, finished_at }' | sed 's/}/},/g' >> output.json
done

echo "]" >> output.json

# https://unix.stackexchange.com/a/163003
perl -00pe 's/,(?!.*,)//s' output.json > output.json.tmp && mv output.json.tmp output.json


pyenv local stability

python - <<EOF
import pandas as pd

with open('output.json', encoding='utf-8') as f:
    df = pd.read_json(f)

df.to_csv('output.csv', encoding='utf-8')
EOF