{{config(materialized="table")}}

WITH source_data AS (
    SELECT
        id_notific AS id_vitima, -- chave da ocorrencia, pois assim cada registro de vitima é único
        dt_nascimento_vitima AS dt_nascimento,
        municipio_residencia,
        idade_vitima AS idade,
        raca_vitima AS raca,
        orient_sex_vitima as orient_sex,
        ident_gen_vitima AS ident_gen
    FROM 
        {{ref('stg_source_ses')}}
)

SELECT
    -- hashed key of multiple fields of the table
    {{ dbt_utils.generate_surrogate_key(['id_vitima', 'dt_nascimento', 'raca', 'orient_sex', 'ident_gen']) }} AS id_vitima,
    dt_nascimento,
    municipio_residencia,
    raca,
    orient_sex,
    ident_gen
FROM 
    source_data