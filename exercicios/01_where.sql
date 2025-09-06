-- 1. Lista de transações com apenas 1 ponto;

SELECT idcliente,
        IdTransacao,
        QtdePontos
FROM transacoes
WHERE QtdePontos = 1;

-- 2. Lista de pedidos realizados no fim de semana;

SELECT IdTransacao,
         IdCliente,
         DtCriacao,
         strftime('%w', datetime(substr(DtCriacao, 1, 19))) AS DiaSemana
FROM transacoes
WHERE DiaSemana IN ('0','6')
ORDER BY DtCriacao DESC;

-- 3. Lista de clientes com 0 (zero) pontos;

SELECT IdCliente,
        QtdePontos
FROM clientes
WHERE QtdePontos = 0;

-- 4. Lista de clientes com 100 a 200 pontos (inclusive ambos);

SELECT IdCliente,
        QtdePontos
FROM clientes
WHERE QtdePontos BETWEEN 100 AND 200;
-- WHERE QtdePontos >= 100 AND QtdePontos <= 200

-- 5. Lista de produtos com nome que começa com “Venda de”;

SELECT *
FROM produtos
WHERE DescProduto LIKE 'Venda de%';

-- 6. Lista de produtos com nome que termina com “Lover”;

SELECT *
FROM produtos 
WHERE DescProduto LIKE '%Lover';

-- 7. Lista de produtos que são “chapéu”;

SELECT *
FROM produtos
WHERE DescProduto LIKE '%chapéu%';

-- 8. Lista de transações com o produto “Resgatar Ponei”;

SELECT tp.IdTransacao,
        p.IdProduto,
        p.DescProduto
FROM transacao_produto tp
LEFT JOIN produtos p
ON tp.IdProduto = p.IdProduto
WHERE p.DescProduto = 'Resgatar Ponei';

-- 9. Listar todas as transações adicionando uma coluna nova sinalizando
-- “alto”, “médio” e “baixo” para o valor dos pontos [<10 ; <500; >=500]

SELECT *,
        CASE
            WHEN QtdePontos < 10 THEN 'baixo'
            WHEN QtdePontos < 500 THEN 'médio'
            ELSE 'alto' 
        END AS NivelPontos
FROM transacoes