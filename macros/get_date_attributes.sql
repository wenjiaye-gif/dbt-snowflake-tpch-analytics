
{% macro get_date_attributes(date_column) %}

    DAY({{ date_column }}) AS day_number,
    DAYNAME({{ date_column }}) AS day_name,

    MONTH({{ date_column }}) AS month_number,
    MONTHNAME({{ date_column }}) AS month_name,

    QUARTER({{ date_column }}) AS quarter_number,

    YEAR({{ date_column }}) AS year_number

{% endmacro %}
