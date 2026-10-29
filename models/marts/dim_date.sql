
WITH order_dates AS (

    SELECT DISTINCT
        o_orderdate AS order_date
    FROM {{ ref('int_tpch_sf1__order_information') }}

),

dim_date AS (

    SELECT
        -- Date key
        TO_NUMBER(TO_CHAR(order_date, 'YYYYMMDD')) AS date_key,

        -- Date information
        order_date,

        -- Year and month
        YEAR(order_date) AS year,
        MONTH(order_date) AS month,

        CASE MONTH(order_date)
            WHEN 1 THEN 'Enero'
            WHEN 2 THEN 'Febrero'
            WHEN 3 THEN 'Marzo'
            WHEN 4 THEN 'Abril'
            WHEN 5 THEN 'Mayo'
            WHEN 6 THEN 'Junio'
            WHEN 7 THEN 'Julio'
            WHEN 8 THEN 'Agosto'
            WHEN 9 THEN 'Septiembre'
            WHEN 10 THEN 'Octubre'
            WHEN 11 THEN 'Noviembre'
            WHEN 12 THEN 'Diciembre'
        END AS month_name

    FROM order_dates

)

SELECT *
FROM dim_date
