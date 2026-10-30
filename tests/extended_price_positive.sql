SELECT *
FROM {{ref('stg_tpch_sf1__LINEITEM')}}
where l_extendedprice < 0