{{ config(
    materialized = 'table',
    schema = 'dw_ecoessentials'
    )
}}

SELECT
distinct {{ dbt_utils.generate_surrogate_key(['emailid']) }} as email_key,
emailid as email_id,
emailname as email_name,
FROM {{ source('eco_landing2', 'marketingemails') }}