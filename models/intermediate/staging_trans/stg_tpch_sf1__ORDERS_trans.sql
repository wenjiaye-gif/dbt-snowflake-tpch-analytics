with source as (

    select *
    from {{ ref('stg_tpch_sf1__ORDERS') }}

),

transformed as (

    select
        o_orderkey,
        o_custkey,
        o_orderstatus,
        o_totalprice,
        o_orderdate,
        {{ extract_year_month('o_orderdate') }},
        o_orderpriority,
        o_shippriority

    from source

)

select * from transformed