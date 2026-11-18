with 

source as (

    select * from {{ source('tpch_sf1', 'CUSTOMER') }}

),

renamed as (

    select *

    from source

)

select * from renamed