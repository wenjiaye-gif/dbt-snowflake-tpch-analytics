{% macro print_target_info() %}

    {{ log("TARGET NAME: " ~ target.name, info=true) }}
    {{ log("TARGET SCHEMA: " ~ target.schema, info=true) }}
    {{ log("TARGET DATABASE: " ~ target.database, info=true) }}
    {{ log("TARGET WAREHOUSE: " ~ target.warehouse, info=true) }}
    {{ log("DBT ENV NAME: " ~ env_var('DBT_ENV_NAME', 'NOT SET'), info=true) }}

{% endmacro %}