{{ config(materialized='table') }}

select 
{{ dbt_utils.surrogate_key(['f.FILM_ID']) }} as FILM_KEY,
f.film_id,
	f.title AS film_title,
	l.name AS LANGUAGE,
	c.name AS category_name,
	f.rental_duration,
	f.RENTAL_RATE,
	f.REPLACEMENT_COST,
	f.LENGTH
<<<<<<< HEAD
FROM {{ source('mysql_sakila','film') }} f 
JOIN {{ source('mysql_sakila','language') }} l ON f.language_id = l.language_id
JOIN {{ source('mysql_sakila','film_category') }} fc ON f.film_id = fc.film_id
JOIN {{ source('mysql_sakila','category') }} c ON fc.category_id = c.category_id
=======
FROM {{ source('mysql_rds_sakila','film') }} f 
JOIN {{ source('mysql_rds_sakila','language') }} l ON f.language_id = l.language_id
JOIN {{ source('mysql_rds_sakila','film_category') }} fc ON f.film_id = fc.film_id
JOIN {{ source('mysql_rds_sakila','category') }} c ON fc.category_id = c.category_id
>>>>>>> dc58255c2889b0364f941f6ee0fd9daa0cc77488
