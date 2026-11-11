{% snapshot customer_snapshot%}

{{
    config(
        target_schema = 'snapshots',
        unique_key = 'c_custkey',
        strategy = 'check',
        check_cols = ['c_custkey','c_address','c_phone']
    )
}}

    select* from {{ source('tpch_sf1', 'CUSTOMER') }}

{% endsnapshot%}