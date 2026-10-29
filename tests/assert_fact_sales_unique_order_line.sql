
SELECT
    order_key,
    line_number,
    COUNT(*) AS number_of_rows

FROM {{ ref('fact_sales') }}

GROUP BY
    order_key,
    line_number

HAVING COUNT(*) > 1
