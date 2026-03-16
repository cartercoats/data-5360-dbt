{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
)}}

select
    e.employee_key,
    d.date_key,
    ec.certification_name,
    ec.certification_cost
from {{ ref('stg_employee_certifications') }} ec
inner join {{ ref('oliver_dim_date') }} d
    on ec.certification_awarded_date = d.date_key
inner join {{ ref('oliver_dim_employee') }} e
    on ec.employee_key = e.employee_key;
