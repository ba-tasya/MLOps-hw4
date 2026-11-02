# MLOps-hw4

dbt-project поверх ClickHouse: `raw (transactions_db.transactions) -> staging -> marts`. Подробное описание в PR.

## Запуск
Положить `train.csv` в папку `data/` (не загружается на гх из-за размера)
```bash
docker compose up -d
docker exec -i clickhouse clickhouse-client --user dbt --password dbt --date_time_input_format best_effort --query "INSERT INTO transactions_db.transactions FORMAT CSVWithNames" < data/train.csv
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
cd dbt
make
make docs
make lint
```
