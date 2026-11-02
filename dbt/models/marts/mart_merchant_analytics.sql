with by_merchant as (

    select
        merchant,
        count() as tx_count,
        round(sum(amount), 2) as turnover,
        round(avg(amount), 2) as avg_amount,
        sum(is_fraud) as fraud_count,
        {{ fraud_rate('sum(is_fraud)', 'count()') }} as fraud_rate
    from {{ ref('stg_transactions') }}
    group by merchant

)

select
    *,
    {{ is_above_overall_rate('fraud_rate', 'fraud_count', 'tx_count') }} as is_suspicious
from by_merchant
