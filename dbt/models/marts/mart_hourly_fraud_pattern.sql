with by_hour as (

    select
        day_of_week,
        transaction_hour,
        any(day_name) as day_name,
        count() as tx_count,
        sum(is_fraud) as fraud_count,
        {{ fraud_rate('sum(is_fraud)', 'count()') }} as fraud_rate
    from {{ ref('stg_transactions') }}
    group by day_of_week, transaction_hour

)

select
    *,
    {{ is_above_overall_rate('fraud_rate', 'fraud_count', 'tx_count') }} as is_high_risk_window
from by_hour
