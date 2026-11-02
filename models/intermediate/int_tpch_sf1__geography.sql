with nation as(

    select*
    from {{ref('stg_tpch_sf1__NATION')}}

),

region as (

    select* 
    from {{ref('stg_tpch_sf1__REGION')}}

),

geography as(
    
    select
        nation.n_nationkey,
        nation.n_name AS nation_name,

        region.r_regionkey,
        region.r_name AS region_name
    
    from nation
    left join region on nation.n_regionkey = region.r_regionkey

)

select*
from geography