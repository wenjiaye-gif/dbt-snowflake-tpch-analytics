
{{ config(materialized="table") }}

WITH order_cost AS (

    SELECT *
    FROM {{ ref('int_tpch_sf1__order_cost') }}

),

fact_sales AS (

    SELECT

        -- Identificadores del pedido
        o_orderkey AS order_key,
        l_linenumber AS line_number,

        -- Claves dimensionales
        o_custkey AS customer_key,
        l_partkey AS product_key,
        l_suppkey AS supplier_key,
        date_key,

        -- Información del pedido
        o_orderstatus AS order_status,

        -- Métricas de ventas
        l_quantity AS quantity_sold,
        gross_sales_amount,
        sales_amount_with_tax,

        -- Métricas de costes y rentabilidad
        product_cost,
        estimated_profit

    FROM order_cost

)

SELECT *
FROM fact_sales
