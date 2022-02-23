{{ config(materialized='table') }}

select
{{ dbt_utils.surrogate_key(['stg_store.STORE_ID']) }} STORE_KEY,
STG_STORE.STORE_ID,
stg_address.DISTRICT,
stg_address.ADDRESS,
stg_address.PHONE,

stg_staff.LAST_NAME,
stg_staff.FIRST_NAME

FROM
{{ ref('stg_store') }}
left join
{{ ref('stg_address') }}
on stg_store.address_id = stg_address.address_id
left join
{{ ref('stg_staff') }}
on stg_store.manager_staff_id = stg_staff.staff_id