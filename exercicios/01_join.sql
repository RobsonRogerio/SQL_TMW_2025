-- • Qual categoria tem mais produtos vendidos?

SELECT 

t1.DescCateogriaProduto,
sum(t2.QtdeProduto) AS TotalVendido

FROM produtos t1

LEFT JOIN transacao_produto t2
ON t1.IdProduto = t2.IdProduto

GROUP BY t1.DescCateogriaProduto
ORDER BY TotalVendido DESC
LIMIT 10;

--******************************--

SELECT

t2.DescCateogriaProduto,
sum(t1.QtdeProduto) AS TotalVendido

FROM transacao_produto t1

LEFT JOIN produtos t2
ON t1.IdProduto = t2.IdProduto

GROUP BY t2.DescCateogriaProduto
ORDER BY TotalVendido DESC
LIMIT 10;

-- • Em 2024, quantas transações de Lovers tivemos?

SELECT

t2.DescCateogriaProduto,
substr(t3.DtCriacao, 1, 4) AS Ano,
count(t3.IdTransacao) AS TotalTransacoes

FROM transacao_produto AS t1

LEFT JOIN produtos AS t2
ON t1.IdProduto = t2.IdProduto

LEFT JOIN transacoes AS t3
ON t1.IdTransacao = t3.IdTransacao

WHERE t2.DescCateogriaProduto = 'lovers'
AND substr(t3.DtCriacao, 1, 4) = '2024'

GROUP BY t2.DescCateogriaProduto, substr(t3.DtCriacao, 1, 4)
ORDER BY TotalTransacoes DESC;

--******************************--

SELECT

count(t1.IdTransacao) AS TotalTransacoes,
substr(t1.DtCriacao, 1, 4) AS Ano,
t3.DescCateogriaProduto

FROM transacoes t1

LEFT JOIN transacao_produto t2
ON t1.IdTransacao = t2.IdTransacao

LEFT JOIN produtos t3
ON t2.IdProduto = t3.IdProduto

WHERE substr(t1.DtCriacao, 1, 4) = '2024'
AND t3.DescCateogriaProduto = 'lovers'

GROUP BY substr(t1.DtCriacao, 1, 4), t3.DescCateogriaProduto
ORDER BY TotalTransacoes DESC;

-- • Qual mês tivemos mais lista de presença assinada?

SELECT 

substr(t1.DtCriacao, 1, 7) AS Mes,
count(DISTINCT t1.IdTransacao) AS TotalTransacoes,
t3.DescProduto

FROM transacoes t1

LEFT JOIN transacao_produto t2
ON t1.IdTransacao = t2.IdTransacao

LEFT JOIN produtos t3
ON t2.IdProduto = t3.IdProduto

WHERE t3.IdProduto = 11

GROUP BY substr(t1.DtCriacao, 6, 2), t3.DescProduto
ORDER BY TotalTransacoes DESC
LIMIT 5;

-- • Qual o total de pontos trocados no Stream Elements em Junho de 2025?

SELECT

substr(t3.DtCriacao, 1, 7) AS Período,
t2.DescCateogriaProduto,
sum(t1.VlProduto) AS TotalPontosTrocados

FROM transacao_produto AS t1

LEFT JOIN produtos AS t2
ON t1.IdProduto = t2.IdProduto

LEFT JOIN transacoes AS t3
ON t1.IdTransacao = t3.IdTransacao

WHERE t2.DescCateogriaProduto = 'streamelements' 
AND t1.VlProduto < 0
AND substr(t3.DtCriacao, 1, 7) = '2025-06';