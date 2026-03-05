{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
    )
}}

SELECT
store_id as store_key,
store_id,
Store_Name,
Street,
City,
State
FROM {{ source('oliver_landing', 'store') }}