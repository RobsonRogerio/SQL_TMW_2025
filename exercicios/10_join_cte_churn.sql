
-- Como foi a curva de churn dos clientes que começaram o curso no dia 2025/08/25 e voltaram no último dia

-- Da forma abaixo não está correto, pois conta clientes que voltaram mas não começaram no primeiro dia

-- SELECT
--     substr(DtCriacao, 1,10) AS Dia,
--     count(DISTINCT IdCliente) AS QtdeClientes   
-- FROM transacoes
-- WHERE DtCriacao >= '2025-08-25'
-- AND DtCriacao < '2025-08-30'
-- GROUP BY substr(DtCriacao, 1,10);

WITH tb_clientes_d1 AS (
    SELECT DISTINCT IdCliente
    FROM transacoes
    WHERE DtCriacao >= '2025-08-25'
    AND DtCriacao < '2025-08-26'
)

SELECT 

    substr(t2.DtCriacao, 1,10) AS Dia,
    count(DISTINCT t1.IdCliente) AS QtdeClientes,
    round(1.* count(DISTINCT t1.IdCliente) / (SELECT count(*) FROM tb_clientes_d1), 2) AS PercentualRetencao,
    round(1 - 1.* count(DISTINCT t1.IdCliente) / (SELECT count(*) FROM tb_clientes_d1), 2) AS Churn

FROM tb_clientes_d1 AS t1

LEFT JOIN transacoes AS t2
ON t1.IdCliente = t2.IdCliente

WHERE t2.DtCriacao >= '2025-08-25'
AND t2.DtCriacao < '2025-08-30'

GROUP BY substr(t2.DtCriacao, 1,10)
ORDER BY Dia;