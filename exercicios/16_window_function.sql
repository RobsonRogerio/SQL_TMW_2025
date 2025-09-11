-- 7. Qual o dia da semana mais ativo de cada usuário?

WITH tb_transacoes_cliente_dia_semana AS (

    SELECT
        IdCliente,
        CASE
            WHEN strftime('%w', datetime(substr(DtCriacao, 1, 10))) = '0' THEN 'Domingo'
            WHEN strftime('%w', datetime(substr(DtCriacao, 1, 10))) = '1' THEN 'Segunda'
            WHEN strftime('%w', datetime(substr(DtCriacao, 1, 10))) = '2' THEN 'Terça'
            WHEN strftime('%w', datetime(substr(DtCriacao, 1, 10))) = '3' THEN 'Quarta'
            WHEN strftime('%w', datetime(substr(DtCriacao, 1, 10))) = '4' THEN 'Quinta'
            WHEN strftime('%w', datetime(substr(DtCriacao, 1, 10))) = '5' THEN 'Sexta'
            WHEN strftime('%w', datetime(substr(DtCriacao, 1, 10))) = '6' THEN 'Sábado'
        END AS NomeDiaSemana,
        count(IdCliente) AS qtdeTransacoesCliente

    FROM transacoes

    GROUP BY IdCliente, NomeDiaSemana
    ),

tb_rn AS (

    SELECT 
        *,
        ROW_NUMBER() OVER (PARTITION BY IdCliente ORDER BY qtdeTransacoesCliente DESC) AS rn

    FROM tb_transacoes_cliente_dia_semana
    )

SELECT
    IdCliente,
    NomeDiaSemana,
    qtdeTransacoesCliente

FROM tb_rn
WHERE rn = 1