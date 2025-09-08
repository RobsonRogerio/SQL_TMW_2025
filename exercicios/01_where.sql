-- selecione todos os clientes

SELECT *
FROM
clientes
--WHERE FlEmail = 1
--WHERE FlEmail != 0
WHERE FlEmail <> 0;

-- selecione todas as transações com QtdePontos maior que 50

SELECT *
FROM
transacoes
WHERE QtdePontos > 50;

-- selecione todos os clientes com mais de 500 pontos

SELECT IdCliente, QtdePontos
FROM
clientes
WHERE QtdePontos > 500
ORDER BY QtdePontos;

-- selecione produtos que possuem a palavra "churn" na DescProduto

SELECT *
FROM
produtos
-- WHERE DescProduto = 'Churn_10pp'
-- OR DescProduto = 'Churn_2pp'
-- OR DescProduto = 'Churn_5pp'
-- WHERE DescProduto IN ('Churn_10pp', 'Churn_2pp', 'Churn_5pp');
-- WHERE DescProduto LIKE '%churn%'
WHERE DescCateogriaProduto = 'churn_model'