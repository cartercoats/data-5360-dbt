{{ config(
    materialized = 'table',
    schema = 'dw_ecoessentials'
    )
}}

SELECT
distinct {{ dbt_utils.generate_surrogate_key(['eventtype']) }} as eventtype_key,
eventtype
FROM {{ source('eco_landing2', 'marketingemails') }}