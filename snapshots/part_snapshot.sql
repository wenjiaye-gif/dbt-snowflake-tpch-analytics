{% snapshot part_snapshot%}

{{
    config(
        target_schema = 'snapshots',
        unique_key = 'p_partkey',
        strategy = 'check',
        check_cols = ['p_partkey','p_size']
    )
}}

    select* from {{ source('tpch_sf1', 'PART') }}

{% endsnapshot%}