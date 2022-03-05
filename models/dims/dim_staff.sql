

{{ config(materialized='table') }}

select 
    {{ dbt_utils.surrogate_key(['staff.staff_id']) }} as staff_key,
    staff.staff_id as staff_id,
    staff.store_id as store_key,
    staff.last_name,
    staff.first_name,
    staff.email,
    concat_ws(' ', staff.last_name, staff.first_name) as full_name,
    staff.username as staff_user_name,
    case staff.ACTIVE
        when 'TRUE' then 'yes'
        else 'no'
    end as active_indicator,
    addr.address as staff_address


from 
    {{ ref('stg_staff') }} as staff

left join 
    {{ ref('stg_address') }} as addr

on staff.address_id = addr.address_id 

