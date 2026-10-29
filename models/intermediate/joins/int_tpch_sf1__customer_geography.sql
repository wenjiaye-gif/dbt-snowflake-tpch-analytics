with customer as(

    select* 
    from {{ref('stg_tpch_sf1__CUSTOMER')}}

),

nation as(

    select*
    from {{ref('stg_tpch_sf1__NATION')}}

),

region as(

    select*
    from {{ref('stg_tpch_sf1__REGION')}}

),

customer_geography AS (

    SELECT
        -- Cliente
        customer.c_custkey,
        customer.c_name,
        customer.c_mktsegment,

        -- Nación
        nation.n_nationkey,
        nation.n_name AS nation_name,

        -- Región
        region.r_regionkey,
        region.r_name AS region_name

    FROM customer

    LEFT JOIN nation
        ON customer.c_nationkey = nation.n_nationkey

    LEFT JOIN region
        ON nation.n_regionkey = region.r_regionkey

)

SELECT *
FROM customer_geography