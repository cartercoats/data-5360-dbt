
  {{ config(
    materialized = 'table',
    schema = 'dw_oliver'
    )
}}


SELECT
c.first_name as customer_first_name,
c.last_name as customer_last_name,
d.date_day,
s.Store_Name,
e.first_name as employee_first_name,
e.last_name as employee_last_name,
p.product_name,
f.unit_price,
f.quantity,
(f.unit_price * f.quantity) line_total

FROM {{ ref('fact_sales') }} f

LEFT JOIN {{ ref('oliver_dim_customer') }} c
    ON f.customer_key = c.customer_key

LEFT JOIN {{ ref('oliver_dim_employee') }} e
    ON f.employee_key = e.employee_key

LEFT JOIN {{ ref('oliver_dim_store') }} s
    ON f.store_key = s.store_key

LEFT JOIN {{ ref('oliver_dim_date') }} d
    ON f.date_key= d.date_key

LEFT JOIN {{ ref('oliver_dim_product') }} p
    ON f.product_key = p.product_key