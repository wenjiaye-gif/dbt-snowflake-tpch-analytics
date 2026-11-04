SELECT o_orderdate, l_shipdate
FROM {{ref('int_tpch_sf1__orders_lineitem')}}
where l_shipdate> o_orderdate