{{config(materialized="table")}}

WITH source_data AS (
    SELECT DISTINCT
        tipo_violencia AS tipo,
        lesao_autoprovocada,
        outras_vezes
    FROM 
        {{ref('stg_source_ses')}}
)

SELECT
    -- hashed key of multiple fields of the table
    {{ dbt_utils.generate_surrogate_key(['tipo', 'lesao_autoprovocada', 'outras_vezes']) }} AS id_violencia,
    tipo,
    lesao_autoprovocada,
    outras_vezes
FROM 
    source_data