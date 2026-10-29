WITH order_information AS (

    SELECT *
    FROM {{ ref('int_tpch_sf1__order_information') }}

),

customer_geography AS (

    SELECT *
    FROM {{ ref('int_tpch_sf1__customer_geography') }}

),

customer_order AS (

    SELECT
        -- Pedido
        order_information.o_orderkey,
        order_information.o_orderdate,
        order_information.order_year,
        order_information.order_month,

        -- Cliente
        order_information.o_custkey,
        customer_geography.c_name,
        customer_geography.c_mktsegment,

        -- Geografía del cliente
        customer_geography.n_nationkey,
        customer_geography.nation_name,
        customer_geography.r_regionkey,
        customer_geography.region_name,

        -- Línea de pedido
        order_information.l_linenumber,
        order_information.l_suppkey,
        order_information.l_quantity,

        -- Importes
        order_information.l_extendedprice,
        order_information.l_discount,
        order_information.l_tax,
        order_information.gross_sales_amount,
        order_information.sales_amount_with_tax,

        -- Producto
        order_information.p_partkey,
        order_information.part_name,
        order_information.part_brand,
        order_information.part_type,
        order_information.part_size,
        order_information.part_container

    FROM order_information

    LEFT JOIN customer_geography
        ON order_information.o_custkey = customer_geography.c_custkey

)

SELECT *
FROM customer_order