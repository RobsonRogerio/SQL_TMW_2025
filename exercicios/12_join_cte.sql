-- 12. Dentre os clientes de janeiro/2025, quantos assistiram o curso de SQL?

WITH tb_clientes_jan2025 AS (
    SELECT DISTINCT
    IdCliente
    FROM
    transacoes
    WHERE DtCriacao >= '2025-01-01'
    AND DtCriacao < '2025-02-01'
    ),

tb_clientes_sql AS (
    SELECT DISTINCT
        IdCliente
    FROM transacoes
    WHERE DtCriacao >= '2025-08-25'
    AND DtCriacao < '2025-08-30'
    )

SELECT 
    count(t1.IdCliente) AS clientes_jan,
    count(t2.IdCliente) as clientes_sql,
    round(1. * count(t2.IdCliente) / count(t1.IdCliente), 2) AS proporção 
FROM tb_clientes_jan2025 t1
LEFT JOIN tb_clientes_sql t2
ON t1.IdCliente = t2.IdCliente