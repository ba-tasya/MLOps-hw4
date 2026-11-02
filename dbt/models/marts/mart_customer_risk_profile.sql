with by_customer as (

    select
        customer_id,
        any(customer_name) as customer_name,
        any(us_state) as us_state,
        min(transaction_time) as first_transaction_at,
        max(transaction_time) as last_transaction_at,
        count() as tx_count,
        sum(is_fraud) as fraud_count,
        {{ fraud_rate('sum(is_fraud)', 'count()') }} as fraud_rate,
        round(avg(amount), 2) as avg_amount,
        round(sum(amount), 2) as total_amount
    from {{ ref('stg_transactions') }}
    group by customer_id

)

select
    *,
    case
        when fraud_rate >= 10 then 'HIGH'
        when fraud_rate > 0 then 'MEDIUM'
        else 'LOW'
    end as risk_segment
from by_customer
