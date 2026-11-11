
{{
    config(
        materialized='incremental',
        unique_key=['l_orderkey', 'l_linenumber'],
        incremental_strategy='merge'
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

    WHERE l_orderkey NOT IN (
        SELECT l_orderkey
        FROM {{ this }}
    )

    {% endif %}

)

select * from renamed
