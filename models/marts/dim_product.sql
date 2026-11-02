
WITH products AS (

    SELECT
        p_partkey,
        p_name,
        p_brand,
        p_type,
        p_size,
        p_container
    FROM {{ ref('stg_tpch_sf1__PART') }}

),

dim_product AS (

    SELECT
        -- Product key
        p_partkey AS product_key,

        -- Product attributes
        p_name AS product_name,
        p_brand AS product_brand,
        p_type AS product_type,
        p_size AS product_size,
        p_container AS product_container

    FROM products

)

SELECT *
FROM dim_product
ORDER BY product_key
