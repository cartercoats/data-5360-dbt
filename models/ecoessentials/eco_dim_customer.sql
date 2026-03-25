{{ config(
    materialized = 'table',
    schema = 'dw_ecoessentials'
    )
}}

SELECT distinct
{{ dbt_utils.generate_surrogate_key(['COALESCE(customer_first_name, subscriberfirstname)','COALESCE(customer_last_name,subscriberlastname)','COALESCE(customer_email,subscriberemail)']) }} customer_key,
COALESCE(customer_first_name, subscriberfirstname) as customer_first_name,
COALESCE(customer_last_name,subscriberlastname) as customer_last_name,
COALESCE(customer_email,subscriberemail) as customer_email,
customer_id,
subscriberid,
customer_phone,
customer_address,
customer_city,
customer_state,
customer_zip,
customer_country
FROM {{ source('eco_landing1', 'customer') }} as t 
FULL OUTER JOIN {{ source('eco_landing2', 'marketingemails') }} as m
on t.customer_first_name = m.subscriberfirstname
and t.customer_last_name = m.subscriberlastname
and t.customer_email = m.subscriberemail