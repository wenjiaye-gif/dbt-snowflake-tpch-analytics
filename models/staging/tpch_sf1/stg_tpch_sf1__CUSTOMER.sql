with 

source as (

    select * from {{ source('tpch_sf1', 'CUSTOMER') }}

),

renamed as (

    select *

    from source

    where dbt_valid_to is null

)

select * from renamed