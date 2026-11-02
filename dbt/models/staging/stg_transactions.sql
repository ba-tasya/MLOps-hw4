with source as (

    select distinct *
    from {{ source('transactions_db', 'transactions') }}

)

select
    {{ dbt_utils.generate_surrogate_key([
        'transaction_time', 'merch', 'cat_id', 'amount', 'name_1', 'name_2',
        'gender', 'street', 'one_city', 'us_state', 'post_code', 'lat', 'lon',
        'population_city', 'jobs', 'merchant_lat', 'merchant_lon', 'target'
    ]) }} as transaction_id,
    {{ dbt_utils.generate_surrogate_key(['name_1', 'name_2', 'street', 'post_code']) }} as customer_id,
    transaction_time,
    toDate(transaction_time) as transaction_date,
    toHour(transaction_time) as transaction_hour,
    {{ dbt_date.day_of_week('transaction_time') }} as day_of_week,
    {{ dbt_date.day_name('transaction_time', short=false) }} as day_name,
    replaceRegexpOne(trim(merch), '^fraud_', '') as merchant,
    lower(trim(cat_id)) as category,
    round(amount, 2) as amount,
    {{ amount_bucket('amount') }} as amount_bucket,
    concat(trim(name_1), ' ', trim(name_2)) as customer_name,
    upper(trim(gender)) as gender,
    upper(trim(us_state)) as us_state,
    trim(one_city) as city,
    lat,
    lon,
    merchant_lat,
    merchant_lon,
    toUInt8(target) as is_fraud
from source
where amount > 0
