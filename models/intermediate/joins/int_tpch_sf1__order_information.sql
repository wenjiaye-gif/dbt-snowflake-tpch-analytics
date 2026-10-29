WITH orders_lineitem AS (

    SELECT *
    FROM {{ ref('int_tpch_sf1__orders_lineitem') }}

),

part AS (

    SELECT *
    FROM {{ ref('stg_tpch_sf1__PART') }}

),

order_information AS (

    SELECT
        -- Pedido
        orders_lineitem.o_orderkey,
        orders_lineitem.o_custkey,
        orders_lineitem.o_orderdate,
        orders_lineitem.order_year,
        orders_lineitem.order_month,

        -- Línea de pedido
        orders_lineitem.l_linenumber,
        orders_lineitem.l_suppkey,
        orders_lineitem.l_quantity,

        -- Importes
        orders_lineitem.l_extendedprice,
        orders_lineitem.l_discount,
        orders_lineitem.l_tax,
        orders_lineitem.gross_sales_amount,
        orders_lineitem.sales_amount_with_tax,

        -- Producto
        part.p_partkey,
        part.p_name AS part_name,
        part.p_brand AS part_brand,
        part.p_type AS part_type,
        part.p_size AS part_size,
        part.p_container AS part_container

    FROM orders_lineitem

    LEFT JOIN part
        ON orders_lineitem.l_partkey = part.p_partkey

)

SELECT *
FROM order_information