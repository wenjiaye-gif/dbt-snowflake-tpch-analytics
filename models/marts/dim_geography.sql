

WITH nation AS (

    SELECT
        n_nationkey,
        n_name,
        n_regionkey
    FROM {{ ref('stg_tpch_sf1__NATION') }}

),

region AS (

    SELECT
        r_regionkey,
        r_name
    FROM {{ ref('stg_tpch_sf1__REGION') }}

),

dim_geography AS (

    SELECT
        -- Geography key
        nation.n_nationkey AS geography_key,

        -- Nation
        nation.n_name AS nation_name,

        -- Region
        region.r_regionkey AS region_key,
        region.r_name AS region_name

    FROM nation

    LEFT JOIN region
        ON nation.n_regionkey = region.r_regionkey

)

SELECT *
FROM dim_geography
ORDER BY geography_key

