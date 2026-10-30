
WITH order_information AS (

    SELECT *
    FROM {{ ref('int_tpch_sf1__order_information') }}

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
        order_information.o_orderkey,
        order_information.o_custkey,
        order_information.o_orderdate,
        order_information.order_year,
        order_information.order_month,
        order_information.o_orderstatus,

        -- Order line
        order_information.l_linenumber,
        order_information.l_suppkey,
        order_information.l_quantity,

        -- Product information
        order_information.p_partkey,
        order_information.part_name,
        order_information.part_brand,
        order_information.part_type,
        order_information.part_size,
        order_information.part_container,

        -- Sales amounts
        order_information.l_extendedprice,
        order_information.l_discount,
        order_information.l_tax,
        order_information.gross_sales_amount,
        order_information.sales_amount_with_tax,

        -- Product cost
        partsupp.ps_supplycost AS product_unit_cost,

        order_information.l_quantity
            * partsupp.ps_supplycost AS product_cost

    FROM order_information

    LEFT JOIN partsupp
        ON order_information.p_partkey = partsupp.ps_partkey
        AND order_information.l_suppkey = partsupp.ps_suppkey

),

order_profit AS (

    SELECT
        *,
        gross_sales_amount - product_cost AS estimated_profit
    FROM order_cost

)

SELECT *
FROM order_profit
