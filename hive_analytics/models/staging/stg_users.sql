with source as (
    select * from {{ source('hive_raw', 'raw_users') }}
),

renamed as (
    select
        cast(user_id as int) as user_id,
        cast(username as string) as username,
        cast(email as string) as email,
        cast(signup_date as date) as signup_date
    from source
)

select * from renamed
