{{ config(materialized='table') }}

select * from {{ source('mysql_sakila', 'city') }}
where _fivetran_deleted = FALSE