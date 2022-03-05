{{ config(materialized='table') }}

SELECT d.DATE_KEY as rental_date_key,
tod.TIMEOFDAY_KEY as rental_timeofday_key,
//HOUR(r.rental_date),
//r.rental_date,
r.rental_id,
c.CUSTOMER_KEY,
f.FILM_KEY,
sd.staff_key,
sl.STORE_LOCATION_KEY,
1 as rental_quantity,
p.amount

FROM {{ source('mysql_rds_sakila','rental') }} r
     JOIN {{ ref('dim_date') }} d ON to_number(to_varchar(to_date(r.rental_date),'YYYYMMDD')) = d.DATE_KEY
     JOIN {{ ref('dim_timeofday') }} tod ON HOUR(r.rental_date) = tod.HROFDAY AND MINUTE(r.rental_date) = tod.MINOFDAY
     JOIN {{ ref('dim_customer') }} c ON r.customer_id = c.customer_id
     JOIN {{ source('mysql_rds_sakila','inventory') }} i ON r.inventory_id = i.inventory_id
     JOIN {{ ref('dim_store') }} sl ON i.store_id = sl.STORE_ID
     JOIN {{ ref('dim_film') }} f on  f.film_id = i.film_id
     JOIN {{ ref('dim_staff') }} sd ON r.staff_id = sd.STAFF_ID
     JOIN  {{ source('mysql_rds_sakila','payment') }} p ON r.rental_id = p.rental_id
        WHERE to_date(r.rental_date) < '2020-01-01'   