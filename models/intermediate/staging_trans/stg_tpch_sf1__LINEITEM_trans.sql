with source as (

    select *
    from {{ ref('stg_tpch_sf1__LINEITEM') }}

),

transformed as (

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
        l_shipmode,

        -- Importe después del descuento
        l_extendedprice * (1 - l_discount)
            as gross_sales_amount,

        -- Importe después del descuento y del impuesto
        l_extendedprice * (1 - l_discount)
            * (1 + l_tax)
            as sales_amount_with_tax

    from source

)

select * from transformed