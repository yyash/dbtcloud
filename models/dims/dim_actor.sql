{{ config(materialized='table') }}

select 
ACTOR_ID AS ID,
--CONCAT_WS(' ', LAST_NAME, FIRST_NAME) as FULL_NAME
CONCAT(FIRST_NAME,' ',LAST_NAME) as FULL_NAME
FROM
{{ ref('stg_actor') }}