{{ config(
    materialized = 'table',
    schema = 'dw_ecoessentials'
    )
}}

SELECT
{{ dbt_utils.generate_surrogate_key(['customer_id']) }} customer_key,
customer_id,
subscriber_id,
customer_first_name,
customer_last_name,
customer_email,
customer_phone,
customer_address,
customer_city,
customer_state,
customer_zip,
customer_country
FROM {{ source('eco_landing1', 'customer') }}