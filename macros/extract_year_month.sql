
{%- macro extract_year_month(date_column) -%}

    YEAR({{ date_column }}) AS order_year,
    MONTH({{ date_column }}) AS order_month

{%- endmacro -%}
