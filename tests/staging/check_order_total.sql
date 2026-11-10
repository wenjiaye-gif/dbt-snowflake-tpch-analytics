WITH orders_lineitem AS (

    SELECT *
    FROM {{ ref('int_tpch_sf1__orders_lineitem') }}

)

SELECT
    o_orderkey,
    MAX(o_totalprice) AS order_total,
    SUM(sales_amount_with_tax) AS details_total

FROM orders_lineitem

GROUP BY o_orderkey

HAVING ABS(
    MAX(o_totalprice) - SUM(sales_amount_with_tax)
) > 1