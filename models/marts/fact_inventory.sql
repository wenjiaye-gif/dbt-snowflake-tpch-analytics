WITH partsupp AS (

    SELECT *
    FROM {{ ref('stg_tpch_sf1__PARTSUPP') }}

),

fact_inventory AS (

    SELECT
        -- Claves dimensionales
        ps_partkey AS product_key,
        ps_suppkey AS supplier_key,

        -- Métricas de inventario
        ps_availqty AS available_quantity,
        ps_supplycost AS unit_supply_cost,

        -- Valor total del inventario
        ps_availqty * ps_supplycost AS inventory_value

    FROM partsupp

)

SELECT *
FROM fact_inventory
