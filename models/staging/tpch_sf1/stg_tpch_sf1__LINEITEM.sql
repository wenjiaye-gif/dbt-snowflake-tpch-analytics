
{{
    config(
        materialized='incremental',
        unique_key=['l_orderkey', 'l_linenumber'],
        incremental_strategy='merge'
    )
}}

WITH source AS (

    SELECT *
    FROM {{ source('tpch_sf1', 'LINEITEM') }}

),

renamed AS (

    SELECT
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
        l_comment,
        update_at

    FROM source

    {% if is_incremental() %}

        WHERE update_at > (
            SELECT COALESCE(MAX(update_at), '1900-01-01'::TIMESTAMP_NTZ)
            FROM {{ this }}
        )

    {% endif %}

)

SELECT * FROM renamed
