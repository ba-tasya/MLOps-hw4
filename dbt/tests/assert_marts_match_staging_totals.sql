with staging as (

    select
        count() as tx_count,
        sum(is_fraud) as fraud_count
    from {{ ref('stg_transactions') }}

),

marts as (

    select
        'mart_fraud_by_category' as mart_name,
        sum(tx_count) as tx_count,
        sum(fraud_count) as fraud_count
    from {{ ref('mart_fraud_by_category') }}
    union all
    select
        'mart_fraud_by_state' as mart_name,
        sum(tx_count) as tx_count,
        sum(fraud_count) as fraud_count
    from {{ ref('mart_fraud_by_state') }}
    union all
    select
        'mart_merchant_analytics' as mart_name,
        sum(tx_count) as tx_count,
        sum(fraud_count) as fraud_count
    from {{ ref('mart_merchant_analytics') }}

)

select marts.*
from marts
cross join staging
where marts.tx_count != staging.tx_count or marts.fraud_count != staging.fraud_count
