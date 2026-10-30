WITH order_cost AS (

    SELECT *
    FROM {{ ref('int_tpch_sf1__order_cost') }}

),

dim_customer AS (

    SELECT *
    FROM {{ ref('dim_customer') }}

),

dim_product AS (

    SELECT *
    FROM {{ ref('dim_product') }}

),

dim_supplier AS (

    SELECT *
    FROM {{ ref('dim_supplier') }}

),

dim_date AS (

    SELECT *
    FROM {{ ref('dim_date') }}

),

fact_sales AS (

    SELECT

        -- Identificadores del pedido
        order_cost.o_orderkey AS order_key,
        order_cost.l_linenumber AS line_number,

        -- Claves dimensionales
        dim_customer.customer_key,
        dim_product.product_key,
        dim_supplier.supplier_key,
        dim_date.date_key,

        -- Información del pedido
        order_cost.o_orderstatus AS order_status,

        -- Métricas de ventas
        order_cost.l_quantity AS quantity_sold,
        order_cost.gross_sales_amount,
        order_cost.sales_amount_with_tax,

        -- Métricas de costes y rentabilidad
        order_cost.product_cost,
        order_cost.estimated_profit

    FROM order_cost

    LEFT JOIN dim_customer
        ON order_cost.o_custkey = dim_customer.customer_key

    LEFT JOIN dim_product
        ON order_cost.l_partkey = dim_product.product_key

    LEFT JOIN dim_supplier
        ON order_cost.l_suppkey = dim_supplier.supplier_key

    LEFT JOIN dim_date
        ON order_cost.o_orderdate = dim_date.full_date

)

SELECT *
FROM fact_sales
