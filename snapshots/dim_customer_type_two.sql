{% snapshot dim_customer_type_two %}

{{
    config(
      unique_key='customer_key',
      strategy='check',
      check_cols='all',
      target_schema='snapshots'
    )
}}

select * from {{ ref('dim_customer') }}

{% endsnapshot %}