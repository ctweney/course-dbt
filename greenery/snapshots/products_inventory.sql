{% snapshot inventory_snapshot %}

{{
  config(
    target_database = target.database,
    target_schema = target.schema,
    strategy='check',
    unique_key='product_id',
    check_cols=['inventory'],
   )
}}

select PRODUCT_ID, INVENTORY 
from {{ source('postgres', 'products') }}

{% endsnapshot %}
