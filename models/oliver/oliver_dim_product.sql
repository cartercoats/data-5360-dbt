{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
    )
}}

SELECT
product_id as product_key,
product_id,
Product_Name,
Description
FROM {{ source('oliver_landing', 'product') }}