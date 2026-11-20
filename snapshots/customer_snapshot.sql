
{% snapshot customer_snapshot %}


{{
    config(
        target_schema = 'snapshots',
        unique_key = 'c_custkey',
        strategy = 'timestamp',
        updated_at = 'update_at'
    )
}}

SELECT *
FROM {{ source('tpch_sf1', 'CUSTOMER') }}

{% endsnapshot %}
