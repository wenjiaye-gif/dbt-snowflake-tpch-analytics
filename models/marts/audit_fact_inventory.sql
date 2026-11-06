
{{ config(enabled = false) }}
{% set old_relation = ref('fct_inventory_deprecated')  -%}

{% set dbt_relation = ref('fct_inventory') %}

{{ audit_helper.compare_and_classify_relation_rows(
    a_relation = old_relation,
    b_relation = dbt_relation,
    primary_key_columns = ["product_key","supplier_key"],
    columns = None
) }}