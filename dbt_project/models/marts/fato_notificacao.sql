{{config(materialized="table")}}

SELECT
    id_notific,

    -- FK -> dim_data
    {{ dbt_utils.generate_surrogate_key(['dt_notificacao']) }} AS id_data,
    -- FK -> dim_vitima
    {{ dbt_utils.generate_surrogate_key(['id_notific', 'dt_nascimento_vitima', 'raca_vitima', 'orient_sex_vitima', 'ident_gen_vitima']) }} AS id_vitima,
    -- FK -> dim_violencia
    {{ dbt_utils.generate_surrogate_key(['tipo_violencia', 'lesao_autoprovocada', 'outras_vezes']) }} AS id_violencia,
    -- FK -> dim_local
    {{ dbt_utils.generate_surrogate_key(['local_ocorrencia']) }} AS id_local,
    -- Métricas
    num_envolvidos,
    autor_sexo
FROM
    {{ref('stg_source_ses')}}