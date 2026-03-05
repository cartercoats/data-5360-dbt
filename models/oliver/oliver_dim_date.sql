{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
    )
}}

with cte_date as (
    {{dbt_date.get_date_dimension("1990-01-01", "2050-12-31")}}
)
SELECT
date_day as date_key,
date_day,
Day_of_Week,
Month_of_year,
month_name,
Quarter_of_year,
Year_number
FROM cte_date