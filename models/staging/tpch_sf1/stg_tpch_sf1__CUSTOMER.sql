with 

source as (

    select * from {{ ref('customer_snapshot') }}

),

renamed as (

    select *

    from source

    where dbt_valid_to is null

)

select * from renamed