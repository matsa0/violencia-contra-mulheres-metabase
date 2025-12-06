{{config(materialized="table")}}

WITH source_data AS (
    SELECT DISTINCT
        dt_notificacao,
        semestre_notificacao as semestre
    FROM 
        {{ref('stg_source_ses')}}
)

SELECT
    -- hashed key of multiple fields of the table
    {{ dbt_utils.generate_surrogate_key(['dt_notificacao']) }} AS id_data,
    dt_notificacao,
    semestre
FROM 
    source_data