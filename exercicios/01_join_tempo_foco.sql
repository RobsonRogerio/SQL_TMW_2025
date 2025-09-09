-- 1. Quais clientes mais perderam pontos por Lover?


SELECT

t1.IdCliente,
sum(t2.VlProduto) AS TotalPontosPerdidos

FROM
transacoes t1

LEFT JOIN transacao_produto t2
ON t1.IdTransacao = t2.IdTransacao

LEFT JOIN produtos t3
ON t2.IdProduto = t3.IdProduto

WHERE t3.DescCateogriaProduto = 'lovers'

GROUP BY t1.IdCliente
ORDER BY TotalPontosPerdidos

LIMIT 5;

-- 2. Quais clientes assinaram a lista de presença no dia 2025/08/25?

SELECT

substr(t1.DtCriacao, 1, 10) AS DataCriacao,
t3.DescProduto,
count(t1.IdCliente) AS TotalClientes

FROM transacoes t1

LEFT JOIN transacao_produto t2
ON t1.IdTransacao = t2.IdTransacao

LEFT JOIN produtos t3
ON t2.IdProduto = t3.IdProduto

WHERE t2.IdProduto = 11
AND substr(t1.DtCriacao, 1, 10) = '2025-08-25'

LIMIT 10;

-- 3. Do início ao fim do nosso curso (2025/08/25 a 2025/08/29), quantos clientes assinaram a lista de presença?

SELECT

t3.DescProduto,
count(DISTINCT t1.IdCliente) AS TotalClientes

FROM transacoes t1

LEFT JOIN transacao_produto t2
ON t1.IdTransacao = t2.IdTransacao

LEFT JOIN produtos t3
ON t2.IdProduto = t3.IdProduto

WHERE t2.IdProduto = 11
AND substr(t1.DtCriacao, 1, 10) >= '2025-08-25'
AND substr(t1.DtCriacao, 1, 10) <= '2025-08-29'

LIMIT 10;

-- 4. Clientes mais antigos, tem mais frequência de transação?

SELECT

t1.IdCliente,
round(julianday('now') - julianday(datetime(substr(t2.DtCriacao, 1, 19)))) AS TempoClienteDias,
count(t1.IdTransacao) AS TotalTransacoes,
round(count(t1.IdTransacao) / (julianday('now') - julianday(datetime(substr(t2.DtCriacao, 1, 10)))), 2) AS FreqTransacoesPorDia

FROM transacoes t1

LEFT JOIN clientes t2
ON t1.IdCliente = t2.IdCliente

GROUP BY t2.IdCliente, TempoClienteDias;