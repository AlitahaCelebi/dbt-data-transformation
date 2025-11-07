{{
    config(
        materialized='table',
        tags=['marts', 'daily']
    )
}}

-- Fact table for orders
-- Contains all order transactions with metrics

with orders as (
    select * from {{ ref('stg_orders') }}
),

customers as (
    select * from {{ ref('stg_customers') }}
),

final as (
    select
        -- Order details
        o.order_id,
        o.order_date,
        o.customer_id,

        -- Customer info
        c.first_name,
        c.last_name,
        c.email,
        c.city,
        c.state,
        c.country,

        -- Order metrics
        o.order_amount,
        o.quantity,
        o.product_id,

        -- Calculated fields
        o.order_amount * o.quantity as total_revenue,

        -- Metadata
        current_timestamp as dbt_updated_at

    from orders o
    left join customers c
        on o.customer_id = c.customer_id
)

select * from final
