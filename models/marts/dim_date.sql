
WITH orders AS (

    SELECT *
    FROM {{ ref('stg_tpch_sf1__ORDERS') }}

),

date_spine AS (

    SELECT DISTINCT
        o_orderdate AS full_date
    FROM orders

),

dim_date AS (

    SELECT
        TO_NUMBER(TO_CHAR(full_date, 'YYYYMMDD')) AS date_key,
        full_date,

        {{ get_date_attributes('full_date') }}

    FROM date_spine

)

SELECT *
FROM dim_date
