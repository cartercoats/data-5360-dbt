{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
)}}

SELECT
    certification_completion_id,
    first_name,
    last_name,
    email,
    employee_id as employee_key,
    PARSE_JSON(certification_json):"certification_name"::STRING AS certification_name,
    PARSE_JSON(certification_json):"certification_cost"::NUMBER AS certification_cost,
    PARSE_JSON(certification_json):"certification_awarded_date"::DATE AS certification_awarded_date
FROM {{ source('oliver_landing', 'employee_certifications') }}