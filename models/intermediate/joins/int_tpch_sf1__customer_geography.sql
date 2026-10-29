{{ config(materialized="view") }}

with
    customer as (select * from {{ ref("stg_tpch_sf1__CUSTOMER") }}),

    geography as (select * from {{ ref("int_tpch_sf1__geography") }}),

    customer_geography as (

        select
            -- Customer
            customer.c_custkey,
            customer.c_name,
            customer.c_mktsegment,

            -- Geography
            geography.n_nationkey,
            geography.nation_name,
            geography.r_regionkey as r_regionkey,
            geography.region_name

        from customer

        left join geography on customer.c_nationkey = geography.n_nationkey

    )

select *
from customer_geography
