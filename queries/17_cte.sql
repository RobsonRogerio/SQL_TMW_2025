-- Clientes que começaram o curso no dia 2025/08/25 e voltaram no último dia 2025/08/29

-- CTE: Common Table Expression

WITH tb_clientes_primeiro_dia AS (
    SELECT DISTINCT IdCliente
    FROM transacoes
    WHERE substr(DtCriacao,1,10) = '2025-08-25'
),

tb_clientes_ultimo_dia AS (
    SELECT DISTINCT IdCliente
    FROM transacoes
    WHERE substr(DtCriacao,1,10) = '2025-08-29'
),

tb_join AS (
    SELECT
    c1.IdCliente AS IdCliente_Primeiro_Dia,
    c2.IdCliente AS IdCliente_Ultimo_Dia

    FROM tb_clientes_primeiro_dia c1
    
    LEFT JOIN tb_clientes_ultimo_dia c2
    ON c1.IdCliente = c2.IdCliente
)

SELECT 
count(IdCliente_Primeiro_Dia), 
count(IdCliente_Ultimo_Dia),
round((1. * count(IdCliente_Ultimo_Dia) / count(IdCliente_Primeiro_Dia)) * 100, 2) AS Percentual_Retorno
FROM tb_join;