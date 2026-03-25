{{ config(
    materialized = 'table',
    schema = 'dw_ecoessentials'
    )
}}

WITH cte_time AS (

    SELECT
        SEQ4() AS seq
    FROM TABLE(GENERATOR(ROWCOUNT => 1440))

)

SELECT
    seq AS time_key,
    DATEADD(minute, seq, '00:00:00'::time) AS time_value,
    DATE_PART(hour, DATEADD(minute, seq, '00:00:00'::time)) AS hour_number,
    DATE_PART(minute, DATEADD(minute, seq, '00:00:00'::time)) AS minute_number,
    CASE 
        WHEN DATE_PART(hour, DATEADD(minute, seq, '00:00:00'::time)) < 12 
        THEN 'AM' 
        ELSE 'PM' 
    END AS am_pm
FROM cte_time