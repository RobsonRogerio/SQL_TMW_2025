-- SELECT

--     IdProduto,
--     count(*)
    
-- FROM
-- transacao_produto
-- GROUP BY IdProduto;

SELECT
    IdCliente,
    sum(QtdePontos) as TotalPontos,
    count(IdTransacao) as TotalTransacoes
FROM
transacoes
WHERE DtCriacao >= '2025-07-01'
  AND DtCriacao < '2025-08-01'

GROUP BY IdCliente
HAVING totalPontos > 4000

ORDER BY TotalPontos DESC
LIMIT 10;