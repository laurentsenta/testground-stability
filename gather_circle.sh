
pyenv local stability

python - <<EOF
import pandas as pd

with open('circleci.json', encoding='utf-8') as f:
    df = pd.read_json(f)

df.to_csv('circleci.csv', encoding='utf-8')
EOF