{{ config(
    materialized = 'table',
    schema = 'dw_ecoessentials'
) }}

SELECT
    d.date_key,
    t.time_key,
    p.product_key,
    o.order_id,
    cu.customer_key,
    ol.quantity,
    ol.discount,
    ol.price_after_discount,
    c.campaign_key,
FROM {{ source('eco_landing1', 'ORDER') }} o
INNER JOIN {{ source('eco_landing1', 'ORDER_LINE') }} ol ON o.order_id = ol.order_id
INNER JOIN {{ ref('eco_dim_campaign') }} c ON ol.campaign_id = c.campaign_id 
INNER JOIN {{ ref('eco_dim_customer') }} cu ON o.Customer_ID = cu.customer_id 
INNER JOIN {{ ref('eco_dim_product') }} p ON ol.product_id = p.product_id 
INNER JOIN {{ ref('eco_dim_date') }} d ON CAST(o.order_timestamp AS DATE) = d.date_day
INNER JOIN {{ ref('eco_dim_time') }} t ON DATE_PART(hour, o.order_timestamp) = t.hour_number
 AND DATE_PART(minute, o.order_timestamp) = t.minute_number
