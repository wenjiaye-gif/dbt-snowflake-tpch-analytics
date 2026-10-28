with 

source as (

    select * from {{ source('tpch_sf1', 'REGION') }}

),

renamed as (

    select
        r_regionkey,
        r_name,
        r_comment

    from source

)

select * from renamed