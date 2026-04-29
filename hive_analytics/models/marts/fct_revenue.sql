with transactions as (
    select * from {{ ref('stg_transactions') }}
),

users as (
    select * from {{ ref('stg_users') }}
),

final as (
    select
        t.category,
        date_format(t.transaction_date, 'yyyy-MM') as revenue_month,
        sum(t.amount) as total_revenue,
        count(distinct t.user_id) as unique_customers
    from transactions t
    join users u on t.user_id = u.user_id
    group by t.category, date_format(t.transaction_date, 'yyyy-MM')
)

select * from final
order by revenue_month desc, total_revenue desc
