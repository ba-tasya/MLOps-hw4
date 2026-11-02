select
    transaction_date,
    us_state,
    count() as tx_count,
    round(sum(amount), 2) as total_amount,
    round(avg(amount), 2) as avg_amount,
    round(quantile(0.95) (amount), 2) as p95_amount,
    round(countIf(amount_bucket in ('large', 'xlarge')) / count(), 4) as large_tx_share
from {{ ref('stg_transactions') }}
group by transaction_date, us_state
