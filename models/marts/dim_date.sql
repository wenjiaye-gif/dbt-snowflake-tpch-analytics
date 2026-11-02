WITH orders_lineitem AS (

    SELECT *
    FROM {{ ref('int_tpch_sf1__orders_lineitem') }}

),

date_spine AS (

    SELECT DISTINCT
        date_key,
        o_orderdate AS full_date
    FROM orders_lineitem

),

dim_date AS (

    SELECT
        date_key,
        full_date,

        {{ get_date_attributes('full_date') }}

    FROM date_spine

)

SELECT *
FROM dim_date