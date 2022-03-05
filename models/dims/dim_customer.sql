{{ config(materialized='table') }}

select 
{{ dbt_utils.surrogate_key(['cust.CUSTOMER_ID']) }} as CUSTOMER_KEY,
cust.CUSTOMER_ID as CUSTOMER_ID,
cust.FIRST_NAME as FIRST_NAME,
cust.LAST_NAME as LAST_NAME,
case when cust.ACTIVE = 'TRUE' then 1 else 0 end as ACTIVE_INDICATOR,
cust.STORE_ID as CUSTOMER_STORE_ID,
cust.EMAIL as EMAIL_ADDRESS,
addr.PHONE as CUSTOMER_CONTACT_NUMBER,
addr.ADDRESS as LINE_1_ADDRESS,
addr.ADDRESS2 as LINE_2_ADDRESS,
addr.DISTRICT as CUSTOMER_DISTRICT,
addr.POSTAL_CODE as CUSTOMER_POSTAL_CODE,
city.CITY as CUSTOMER_CITY,
country.COUNTRY as COUNTRY
from {{ ref('stg_customer') }} cust 
join {{ ref('stg_address') }} addr on cust.ADDRESS_ID = addr.ADDRESS_ID
join {{ ref('stg_city') }} city on addr.CITY_ID = city.CITY_ID
join {{ ref('stg_country') }} country on city.COUNTRY_ID = country.COUNTRY_ID


