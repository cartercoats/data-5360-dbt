{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
    )
}}

SELECT
c.customer_id as customer_key,
o.order_date as date_key,
s.store_id as store_key,
p.product_id as product_key,
e.employee_id as employee_key,
quantity,
(quantity * ol.unit_price) as dollars_sold,
ol.unit_price
FROM {{ source('oliver_landing', 'orderline') }} as ol
JOIN {{ source('oliver_landing', 'orders') }} as o on ol.order_id = o.order_id
JOIN {{ source('oliver_landing', 'customer') }} as c on c.customer_id = o.customer_id
JOIN {{ source('oliver_landing', 'store') }} as s on s.store_id = o.store_id
JOIN {{ source('oliver_landing', 'product') }} as p on p.product_id = ol.product_id
JOIN {{ source('oliver_landing', 'employee') }} as e on e.employee_id = o.employee_id


