with source as (

    select *
    from {{ ref('stg_tpch_sf1__CUSTOMER') }}

),

final as (

    select *
    from source
    where C_ACCTBAL < 0

)

select *
from final