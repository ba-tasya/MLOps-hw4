select *
from {{ ref('mart_customer_risk_profile') }}
where fraud_count > tx_count or first_transaction_at > last_transaction_at
