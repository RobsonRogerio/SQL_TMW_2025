-- Clientes que começaram o curso no dia 2025/08/25 e voltaram no último dia 2025/08/29
-- CTE: Common Table Expression

-- SELECT count(DISTINCT IdCliente)

-- FROM transacoes t1

-- WHERE t1.IdCliente IN (
--     SELECT DISTINCT IdCliente
--     FROM transacoes
--     WHERE substr(DtCriacao,1,10) = '2025-08-25'
-- )
-- AND substr(t1.DtCriacao,1,10) = '2025-08-29';


WITH tb_clientes_primeiro_dia AS (
    SELECT DISTINCT IdCliente
    FROM transacoes
    WHERE substr(DtCriacao,1,10) = '2025-08-25'
),

tb_clientes_ultimo_dia AS (
    SELECT DISTINCT IdCliente
    FROM transacoes
    WHERE substr(DtCriacao,1,10) = '2025-08-29'
)

SELECT *
FROM tb_clientes_primeiro_dia c1
LEFT JOIN tb_clientes_ultimo_dia c2
ON c1.IdCliente = c2.IdCliente;