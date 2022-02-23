{{ config(materialized='table') }}

select * from {{ source('mysql_sakila', 'customer') }}
where _fivetran_deleted = FALSE