{{config(materialized="view")}}

SELECT
    id as id_notific,
    dt_nascimento_vitima,
    municipio_residencia,
    idade_vitima,
    raca_vitima,
    orient_sex_vitima,
    ident_gen_vitima,
    dt_notificacao,
    local_ocorrencia,
    num_envolvidos,
    tipo_violencia,
    lesao_autoprovocada,
    outras_vezes,
    autor_sexo,
    CASE
        WHEN EXTRACT(MONTH FROM dt_notificacao) IN 
        (1,2,3,4,5,6) THEN '1º Semestre' ELSE '2º Semestre'
    END AS semestre_notificacao
FROM {{source('ses_source', 'dados_completos')}}