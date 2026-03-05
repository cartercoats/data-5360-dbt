{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
    )
}}

SELECT
customer_key,
date_key,
store_key,
product_key,
employee_key,
quantity,
dollars_sold,
unit_price
FROM {{ source('oliver_landing', 'orderline') }} as ol
JOIN {{ source('oliver_landing', 'orders') }} as o on ol.order_id = o.order_id
JOIN {{ source('oliver_landing', 'orderline') }} as
JOIN {{ source('oliver_landing', 'orderline') }} as
JOIN {{ source('oliver_landing', 'orderline') }} as
JOIN {{ source('oliver_landing', 'orderline') }} as