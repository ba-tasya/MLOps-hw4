with by_category as (

    select
        category,
        count() as tx_count,
        sum(is_fraud) as fraud_count,
        {{ fraud_rate('sum(is_fraud)', 'count()') }} as fraud_rate,
        round(sum(amount), 2) as total_amount,
        round(sumIf(amount, is_fraud = 1), 2) as fraud_amount
    from {{ ref('stg_transactions') }}
    group by category

)

select
    *,
    row_number() over (order by fraud_rate desc) as fraud_rank
from by_category
