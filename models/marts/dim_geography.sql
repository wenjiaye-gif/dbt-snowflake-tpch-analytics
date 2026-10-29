WITH geography AS (

    SELECT *
    FROM {{ ref('int_tpch_sf1__geography') }}

),

dim_geography AS (

    SELECT
        n_nationkey AS geography_key,
        nation_name,
        r_regionkey AS region_key,
        region_name

    FROM geography

)

SELECT *
FROM dim_geography
ORDER BY geography_key

