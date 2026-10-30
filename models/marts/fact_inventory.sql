

WITH partsupp AS (
    SELECT *
    FROM {{ ref("stg_tpch_sf1__PARTSUPP") }}
),

dim_product AS (
    SELECT *
    FROM {{ ref("dim_product") }}
),

dim_supplier AS (
    SELECT *
    FROM {{ ref("dim_supplier") }}
),

fact_inventory AS (
    SELECT
        dim_product.product_key,
        dim_supplier.supplier_key,
        partsupp.ps_availqty AS available_quantity,
        partsupp.ps_supplycost AS unit_supply_cost,
        partsupp.ps_availqty * partsupp.ps_supplycost AS inventory_value
    FROM partsupp
    LEFT JOIN dim_product
        ON partsupp.ps_partkey = dim_product.product_key
    LEFT JOIN dim_supplier
        ON partsupp.ps_suppkey = dim_supplier.supplier_key
)

SELECT *
FROM fact_inventory
