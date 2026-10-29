
WITH customer_order AS (

    SELECT *
    FROM {{ ref('int_tpch_sf1__customer_order') }}

),

dim_date AS (

    SELECT
        date_key,
        order_date
    FROM {{ ref('dim_date') }}

),

dim_product AS (

    SELECT
        product_key
    FROM {{ ref('dim_product') }}

),

dim_geography AS (

    SELECT
        geography_key,
        nation_name,
        region_name
    FROM {{ ref('dim_geography') }}

),

fact_sales AS (

    SELECT
        -- Degenerate dimensions / order identifiers
        customer_order.o_orderkey AS order_key,
        customer_order.l_linenumber AS line_number,

        -- Dimension keys
        dim_date.date_key,
        dim_product.product_key,
        dim_geography.geography_key,

        -- Order status
        customer_order.o_orderstatus AS order_status,

        -- Sales measures
        customer_order.l_quantity AS quantity_sold,
        customer_order.gross_sales_amount,
        customer_order.sales_amount_with_tax,
        customer_order.product_cost,
        customer_order.estimated_profit

    FROM customer_order

    LEFT JOIN dim_date
        ON customer_order.o_orderdate = dim_date.order_date

    LEFT JOIN dim_product
        ON customer_order.p_partkey = dim_product.product_key

    LEFT JOIN dim_geography
        ON customer_order.n_nationkey = dim_geography.geography_key

)

SELECT *
FROM fact_sales
