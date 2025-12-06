{{config(materialized="table")}}

WITH source_data AS (
    SELECT DISTINCT
        local_ocorrencia
    FROM 
        {{ref('stg_source_ses')}}
)

SELECT
    -- hashed key of multiple fields of the table
    {{ dbt_utils.generate_surrogate_key(['local_ocorrencia']) }} AS id_local,
    local_ocorrencia
FROM 
    source_data