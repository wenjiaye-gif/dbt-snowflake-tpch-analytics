

WITH customer AS (

    SELECT *
    FROM {{ ref("stg_tpch_sf1__CUSTOMER") }}

),

geography AS (

    SELECT *
    FROM {{ ref("int_tpch_sf1__geography") }}

),

dim_customer AS (

    SELECT
        -- Customer identifiers
        customer.c_custkey AS customer_key,

        -- Customer attributes
        customer.c_name AS customer_name,
        customer.c_mktsegment AS market_segment,

        -- Geographic attributes
        geography.n_nationkey AS nation_key,
        geography.nation_name,
        geography.r_regionkey AS region_key,
        geography.region_name

    FROM customer

    LEFT JOIN geography
        ON customer.c_nationkey = geography.n_nationkey

)

SELECT *
FROM dim_customer
