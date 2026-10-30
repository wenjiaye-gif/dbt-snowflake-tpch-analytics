
WITH orders_lineitem AS (

    SELECT *
    FROM {{ ref('int_tpch_sf1__orders_lineitem') }}

),

partsupp AS (

    SELECT
        ps_partkey,
        ps_suppkey,
        ps_supplycost
    FROM {{ ref('stg_tpch_sf1__PARTSUPP') }}

),

order_cost AS (

    SELECT
        -- Order information
        orders_lineitem.o_orderkey,
        orders_lineitem.o_custkey,
        orders_lineitem.date_key,
        orders_lineitem.o_orderstatus,

        -- Order line identifiers
        orders_lineitem.l_linenumber,
        orders_lineitem.l_partkey,
        orders_lineitem.l_suppkey,

        -- Order line information
        orders_lineitem.l_quantity,
        orders_lineitem.l_extendedprice,
        orders_lineitem.l_discount,
        orders_lineitem.l_tax,

        -- Sales amounts
        orders_lineitem.gross_sales_amount,
        orders_lineitem.sales_amount_with_tax,

        -- Product cost
        partsupp.ps_supplycost AS product_unit_cost,

        orders_lineitem.l_quantity
            * partsupp.ps_supplycost AS product_cost

    FROM orders_lineitem

    LEFT JOIN partsupp
        ON orders_lineitem.l_partkey = partsupp.ps_partkey
        AND orders_lineitem.l_suppkey = partsupp.ps_suppkey

),

order_profit AS (

    SELECT
        *,
        gross_sales_amount - product_cost AS estimated_profit
    FROM order_cost

)

SELECT *
FROM order_profit
