{{ config(materialized='table') }}

select * from {{ source('mysql_sakila', 'country') }}
where _fivetran_deleted = FALSE