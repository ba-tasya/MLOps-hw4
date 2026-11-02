with by_state as (

    select
        us_state,
        count() as tx_count,
        sum(is_fraud) as fraud_count,
        {{ fraud_rate('sum(is_fraud)', 'count()') }} as fraud_rate,
        uniqExact(customer_id) as unique_customers,
        uniqExact(merchant) as unique_merchants,
        round(sum(amount), 2) as total_amount,
        round(sumIf(amount, is_fraud = 1), 2) as fraud_amount
    from {{ ref('stg_transactions') }}
    group by us_state

)

select
    by_state.*,
    states.state_name
from by_state
left join {{ ref('states') }} as states
    on by_state.us_state = states.state_code
