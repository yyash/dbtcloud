{{ config(materialized='table') }}

SELECT 
{{ dbt_utils.surrogate_key(['s.store_id']) }} as STORE_LOCATION_KEY ,
    s.store_id,
	a.postal_code,
	c.city,
	a.district,
	co.country,
	a.phone
FROM {{ source('mysql_rds_sakila','store') }} s
JOIN {{ source('mysql_rds_sakila','address') }} a ON s.address_id = a.address_id
JOIN {{ source('mysql_rds_sakila','city') }} c ON a.city_id = c.city_id
JOIN {{ source('mysql_rds_sakila','country') }} co ON c.country_id = co.country_id