{{ config(enabled = false) }}

SELECT
    order_key,
    line_number,
    quantity_sold
FROM {{ ref('fact_sales') }}
WHERE quantity_sold < 0
