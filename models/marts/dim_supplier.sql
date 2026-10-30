
WITH supplier AS (

    SELECT *
    FROM {{ ref('stg_tpch_sf1__SUPPLIER') }}

),

geography AS (

    SELECT *
    FROM {{ ref('int_tpch_sf1__geography') }}

),

dim_supplier AS (

    SELECT
        supplier.s_suppkey AS supplier_key,

        supplier.s_name AS supplier_name,
        supplier.s_address AS supplier_address,
        supplier.s_phone AS supplier_phone,
        supplier.s_acctbal AS account_balance,
        supplier.s_comment AS supplier_comment,

        geography.n_nationkey AS nation_key,
        geography.nation_name,
        geography.r_regionkey AS region_key,
        geography.region_name

    FROM supplier

    LEFT JOIN geography
        ON supplier.s_nationkey = geography.n_nationkey

)

SELECT *
FROM dim_supplier

