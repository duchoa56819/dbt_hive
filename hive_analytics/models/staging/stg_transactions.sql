with source as (
    select * from {{ source('hive_raw', 'raw_transactions') }}
),

renamed as (
    select
        cast(transaction_id as int) as transaction_id,
        cast(user_id as int) as user_id,
        cast(amount as decimal(10,2)) as amount,
        cast(category as string) as category,
        cast(transaction_date as date) as transaction_date
    from source
)

select * from renamed
