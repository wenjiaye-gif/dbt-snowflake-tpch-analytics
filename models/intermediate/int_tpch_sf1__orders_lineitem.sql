
WITH orders AS (

    SELECT *
    FROM {{ ref('stg_tpch_sf1__ORDERS') }}

),

lineitem AS (

    SELECT *
    FROM {{ ref('stg_tpch_sf1__LINEITEM') }}

),

orders_lineitem AS (

    SELECT
        -- Identificadores del pedido
        orders.o_orderkey,
        orders.o_custkey,

        -- Información del pedido
        orders.o_orderstatus,
        orders.o_totalprice,
        orders.o_orderdate,

        TO_NUMBER(TO_CHAR(orders.o_orderdate, 'YYYYMMDD')) AS date_key,

        orders.o_orderpriority,
        orders.o_shippriority,

        -- Identificadores de la línea de venta
        lineitem.l_linenumber,
        lineitem.l_partkey,
        lineitem.l_suppkey,

        -- Información de la línea
        lineitem.l_quantity,
        lineitem.l_extendedprice,
        lineitem.l_discount,
        lineitem.l_tax,
        lineitem.l_returnflag,
        lineitem.l_linestatus,
        lineitem.l_shipdate,
        lineitem.l_commitdate,
        lineitem.l_receiptdate,
        lineitem.l_shipmode,

        -- Importe después del descuento
        lineitem.l_extendedprice * (1 - lineitem.l_discount)
            AS gross_sales_amount,

        -- Importe después del descuento y del impuesto
        lineitem.l_extendedprice * (1 - lineitem.l_discount)
            * (1 + lineitem.l_tax)
            AS sales_amount_with_tax,

        -- Diferencia de días entre pedido y envío
        {{ calculate_diff_days(
            'orders.o_orderdate',
            'lineitem.l_shipdate'
        ) }} AS days_to_ship

    FROM orders

    INNER JOIN lineitem
        ON orders.o_orderkey = lineitem.l_orderkey

)

SELECT *
FROM orders_lineitem
