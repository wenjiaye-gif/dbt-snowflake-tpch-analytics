
WITH order_cost AS (

    SELECT *
    FROM {{ ref('int_tpch_sf1__order_cost') }}

),

customer_geography AS (

    SELECT *
    FROM {{ ref('int_tpch_sf1__customer_geography') }}

),

customer_order AS (

    SELECT
        -- Order information
        order_cost.o_orderkey,
        order_cost.o_orderdate,
        order_cost.order_year,
        order_cost.order_month,
        order_cost.o_orderstatus,

        -- Customer information
        order_cost.o_custkey,
        customer_geography.c_name,
        customer_geography.c_mktsegment,

        -- Geographic information
        customer_geography.n_nationkey,
        customer_geography.nation_name,
        customer_geography.r_regionkey,
        customer_geography.region_name,

        -- Order line
        order_cost.l_linenumber,
        order_cost.l_suppkey,
        order_cost.l_quantity,

        -- Product information
        order_cost.p_partkey,
        order_cost.part_name,
        order_cost.part_brand,
        order_cost.part_type,
        order_cost.part_size,
        order_cost.part_container,

        -- Sales amounts
        order_cost.l_extendedprice,
        order_cost.l_discount,
        order_cost.l_tax,
        order_cost.gross_sales_amount,
        order_cost.sales_amount_with_tax,

        -- Product cost and estimated profit
        order_cost.product_unit_cost,
        order_cost.product_cost,
        order_cost.estimated_profit

    FROM order_cost

    LEFT JOIN customer_geography
        ON order_cost.o_custkey = customer_geography.c_custkey

)

SELECT *
FROM customer_order
