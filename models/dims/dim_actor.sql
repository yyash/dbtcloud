{{ config(materialized='table') }}

select 
{{ dbt_utils.surrogate_key(['stg_actor.actor_id']) }} ACTOR_KEY,
ACTOR_ID AS ID,
--CONCAT_WS(' ', LAST_NAME, FIRST_NAME) as FULL_NAME
CONCAT(FIRST_NAME,' ',LAST_NAME) as FULL_NAME
FROM
{{ ref('stg_actor') }}