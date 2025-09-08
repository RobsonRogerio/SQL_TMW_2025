-- 1. Quantos clientes tem email cadastrado?

SELECT
    'Clientes com email cadastrado' AS Descricao,
    sum(FlEmail) AS TotalClientesComEmail
FROM clientes;

-- 2. Qual cliente juntou mais pontos positivos em 2025-05?

SELECT
    IdCliente,
    sum(QtdePontos) AS PontosPositivos
FROM transacoes
WHERE DtCriacao >= '2025-05-01'
  AND DtCriacao < '2025-06-01'
  AND QtdePontos > 0
GROUP BY IdCliente
ORDER BY sum(QtdePontos) DESC
LIMIT 1;

-- 3. Qual cliente fez mais transações no ano de 2024?

SELECT
    IdCliente,
    substr(DtCriacao, 1, 4) AS Ano,
    count(*) AS TotalTransacoes
FROM transacoes

WHERE strftime('%Y', datetime(substr(DtCriacao, 1, 10))) = '2024'

GROUP BY IdCliente, Ano
ORDER BY TotalTransacoes DESC
LIMIT 1;

-- 4. Quantos produtos são de rpg?

SELECT
    DescCateogriaProduto,
    count(*) AS TotalProdutos
FROM produtos
WHERE DescCateogriaProduto = 'rpg'
GROUP BY DescCateogriaProduto;

-- 5. Qual o valor médio de pontos positivos por dia?

SELECT
    sum(QtdePontos) AS TotalPontosPositivos,

    count(DISTINCT substr(DtCriacao, 1, 10)) AS TotalDiasComTransacoes,
    
    sum(QtdePontos) / count(DISTINCT substr(DtCriacao, 1, 10)) AS MédiaPontosPositivosPorDia

FROM transacoes
WHERE QtdePontos > 0;

-- 6. Qual dia da semana com mais pedidos em 2025?

SELECT
    strftime('%Y', datetime(substr(DtCriacao, 1, 10))) AS Ano,
    count(IdTransacao) AS TotalTransacoes,
    CASE
        WHEN strftime('%w', datetime(substr(DtCriacao, 1, 10))) = '0' THEN 'Domingo'
        WHEN strftime('%w', datetime(substr(DtCriacao, 1, 10))) = '1' THEN 'Segunda'
        WHEN strftime('%w', datetime(substr(DtCriacao, 1, 10))) = '2' THEN 'Terça'
        WHEN strftime('%w', datetime(substr(DtCriacao, 1, 10))) = '3' THEN 'Quarta'
        WHEN strftime('%w', datetime(substr(DtCriacao, 1, 10))) = '4' THEN 'Quinta'
        WHEN strftime('%w', datetime(substr(DtCriacao, 1, 10))) = '5' THEN 'Sexta'
        WHEN strftime('%w', datetime(substr(DtCriacao, 1, 10))) = '6' THEN 'Sábado'
    END AS NomeDiaSemana
FROM transacoes
WHERE strftime('%Y', datetime(substr(DtCriacao, 1, 10))) = '2025'
GROUP BY NomeDiaSemana
ORDER BY TotalTransacoes DESC
LIMIT 1;

-- 7. Qual o produto mais transacionado?

SELECT
    p.IdProduto,
    p.DescProduto,
    count(tp.IdProduto) AS TotalTransacoes
FROM
transacao_produto tp
LEFT JOIN produtos p
ON tp.IdProduto = p.IdProduto
GROUP BY p.IdProduto, p.DescProduto
ORDER BY TotalTransacoes DESC
LIMIT 1;

-- 8. Qual o produto com mais pontos transacionado?

SELECT
    p.IdProduto,
    p.DescProduto,
    sum(tp.VlProduto) AS TotalPontos,
    sum(tp.QtdeProduto) AS TotalQuantidade,
    sum(tp.VlProduto * tp.QtdeProduto) AS ProdutoPontosQuantidade
FROM
transacao_produto tp
LEFT JOIN produtos p
ON tp.IdProduto = p.IdProduto
GROUP BY p.IdProduto, p.DescProduto
ORDER BY TotalPontos DESC
LIMIT 1;