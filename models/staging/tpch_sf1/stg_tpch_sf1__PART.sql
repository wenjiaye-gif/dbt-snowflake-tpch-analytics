with 

source as (

    select * from {{ ref('part_snapshot') }}

),

renamed as (

    select
        p_partkey,
        p_name,
        p_mfgr,
        p_brand,
        p_type,
        p_size,
        p_container,
        p_retailprice,
        p_comment

    from source
    where dbt_valid_to is null
)

select * from renamed