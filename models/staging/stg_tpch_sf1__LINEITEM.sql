
{{
    config(
        materialized='incremental',
        unique_key=['l_orderkey', 'l_linenumber']
    )
}}

with

source as (

    select * from {{ source('tpch_sf1', 'LINEITEM') }}

),

renamed as (

    select
        l_orderkey,
        l_partkey,
        l_suppkey,
        l_linenumber,
        l_quantity,
        l_extendedprice,
        l_discount,
        l_tax,
        l_returnflag,
        l_linestatus,
        l_shipdate,
        l_commitdate,
        l_receiptdate,
        l_shipinstruct,
        l_shipmode,
        l_comment

    from source

    {% if is_incremental() %}

    where l_shipdate > (
        select coalesce(max(l_shipdate), '1900-01-01'::date)
        from {{ this }}
    )

    {% endif %}

)

select * from renamed
