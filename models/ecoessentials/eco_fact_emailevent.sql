{{ config(
    materialized = 'table',
    schema = 'dw_ecoessentials'
) }}

SELECT
    e.email_key,
    c.campaign_key,
    cu.customer_key,
    et.eventtype_key,
    d_send.date_key AS send_date_key,
    d_event.date_key AS event_date_key,
    t_send.time_key AS send_time_key,
    t_event.time_key AS event_time_key
FROM {{ source('eco_landing2', 'marketingemails') }} m
INNER JOIN {{ ref('eco_dim_email') }} e ON m.emailid = e.email_id 
INNER JOIN {{ ref('eco_dim_customer') }} cu ON m.subscriberID = cu.subscriberid 
INNER JOIN {{ ref('eco_dim_campaign') }} c ON m.campaignid = c.campaign_id 
INNER JOIN {{ ref('eco_dim_eventtype') }} et ON m.eventtype = et.eventtype
INNER JOIN {{ ref('eco_dim_date') }} d_event ON CAST(m.eventtimestamp AS DATE) = d_event.date_day
INNER JOIN {{ ref('eco_dim_date') }} d_send ON CAST(m.sendtimestamp AS DATE) = d_send.date_day
INNER JOIN {{ ref('eco_dim_time') }} t_send ON DATE_PART(hour, m.sendtimestamp) = t_send.hour_number
 AND DATE_PART(minute, m.sendtimestamp) = t_send.minute_number
INNER JOIN {{ ref('eco_dim_time') }} t_event ON DATE_PART(hour, m.eventtimestamp) = t_event.hour_number
 AND DATE_PART(minute, m.eventtimestamp) = t_event.minute_number