{{ config(materialized='view') }}

WITH customer AS (

    SELECT *
    FROM {{ ref('stg_tpch_sf1__CUSTOMER') }}

),

geography AS (

    SELECT *
    FROM {{ ref('int_tpch_sf1__geography') }}

),

customer_geography AS (

    SELECT
        -- Customer
        customer.c_custkey,
        customer.c_name,
        customer.c_mktsegment,

        -- Geography
        geography.n_nationkey,
        geography.nation_name,
        geography.r_regionkey AS r_regionkey,
        geography.region_name

    FROM customer

    LEFT JOIN geography
        ON customer.c_nationkey = geography.n_nationkey

)

SELECT *
FROM customer_geography