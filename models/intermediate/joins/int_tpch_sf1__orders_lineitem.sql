WITH orders AS (

    SELECT *
    FROM {{ ref('stg_tpch_sf1__ORDERS_trans') }}

),

lineitem AS (

    SELECT *
    FROM {{ ref('stg_tpch_sf1__LINEITEM_trans') }}

),

orders_lineitem AS (

    SELECT
        -- Identificadores del pedido
        orders.o_orderkey,
        orders.o_custkey,

        -- Fecha del pedido
        orders.o_orderdate,
        orders.order_year,
        orders.order_month,
        orders.o_orderstatus,

        -- Identificadores de la línea de venta
        lineitem.l_linenumber,
        lineitem.l_partkey,
        lineitem.l_suppkey,
        lineitem.l_shipdate,

        -- Métricas de venta
        lineitem.l_quantity,
        lineitem.l_extendedprice,
        lineitem.l_discount,
        lineitem.l_tax,
        lineitem.gross_sales_amount,
        lineitem.sales_amount_with_tax,
        {{ calculate_diff_days(
            'orders.o_orderdate',
            'lineitem.l_shipdate') }} AS days_to_ship


    FROM orders

    INNER JOIN lineitem
        ON orders.o_orderkey = lineitem.l_orderkey

)

SELECT *
FROM orders_lineitem