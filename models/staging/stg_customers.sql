{{
    config(
        materialized='view',
        tags=['staging', 'daily']
    )
}}

-- Staging model for customers
-- Clean and standardize raw customer data

with source as (
    select * from {{ source('raw', 'customers') }}
),

renamed as (
    select
        -- IDs
        customer_id,

        -- Customer details
        trim(lower(first_name)) as first_name,
        trim(lower(last_name)) as last_name,
        trim(lower(email)) as email,

        -- Location
        trim(city) as city,
        trim(state) as state,
        trim(country) as country,

        -- Metadata
        created_at,
        updated_at

    from source
    where customer_id is not null
)

select * from renamed
