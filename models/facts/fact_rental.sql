{{ config(materialized='table') }}

select 
sr.rental_id,
dc.CUSTOMER_KEY,
ds.STAFF_KEY,
1 as RENTAL_QUANTITY
from
{{ ref('stg_rental') }} sr
left join {{ ref('dim_customer') }} dc on sr.customer_id = dc.customer_id
left join {{ ref('dim_staff') }} ds on sr.staff_id = ds.staff_id