-- Projeto Final

-- Vamos construir uma tabela com o perfil comportamental dos nossos usuários.

-- 1. Quantidade de transações históricas (vida, D7, D14, D28, D56);
-- 2. Dias desde a última transação
-- 3. Idade na base
-- 4. Produto mais usado (vida, D7, D14, D28, D56);
-- 5. Saldo de pontos atual;
-- 6. Pontos acumulados positivos (vida, D7, D14, D28, D56);
-- 7. Pontos acumulados negativos (vida, D7, D14, D28, D56);
-- 8. Dias da semana mais ativos (D28)
-- 9. Período do dia mais ativo (D28)
-- 10. Engajamento em D28 versus Vida

--******************************************************************************--


-- 1. Quantidade de transações históricas (vida, D7, D14, D28, D56);

WITH tb_transacoes AS (

    SELECT
        IdTransacao,
        IdCliente,
        QtdePontos,
        datetime(substr(DtCriacao, 1, 10)) AS dtCriacao,
        round(julianday('now') - julianday(substr(DtCriacao,1,10)), 2) AS diffDate
    FROM transacoes
    ),

tb_cliente AS (
    SELECT
        IdCliente,
        datetime(substr(DtCriacao, 1, 10)) AS dtCriacao,
        round(julianday('now') - julianday(substr(DtCriacao,1,10)), 2) AS idadeBase -- 3. Idade na base
    FROM clientes
    ),

tb_sumario_transacoes AS (

    SELECT
        IdCliente,
        count(IdTransacao) AS qtdeTransacoesVida,
        count(CASE WHEN diffDate <= 56 THEN IdTransacao END) as qtdeTransacoes56,
        count(CASE WHEN diffDate <= 28 THEN IdTransacao END) as qtdeTransacoes28,
        count(CASE WHEN diffDate <= 14 THEN IdTransacao END) as qtdeTransacoes14,
        count(CASE WHEN diffDate <= 7 THEN IdTransacao END) as qtdeTransacoes7,
        
        -- 2. Dias desde a última transação
        round(min(diffDate), 2) AS diasUltimaInteracao, 
        
        -- 5. Saldo de pontos atual;
        sum(QtdePontos) AS saldoPontos, 
        
        -- 6. Pontos acumulados positivos (vida, D7, D14, D28, D56);
        sum(CASE WHEN QtdePontos > 0 THEN QtdePontos ELSE 0 END) qtdePontosPositVida,
        sum(CASE WHEN QtdePontos > 0 AND diffDate <= 56 THEN QtdePontos ELSE 0 END) AS qtdePontosPosit56, 
        sum(CASE WHEN QtdePontos > 0 AND diffDate <= 28 THEN QtdePontos ELSE 0 END) AS qtdePontosPosit28, 
        sum(CASE WHEN QtdePontos > 0 AND diffDate <= 14 THEN QtdePontos ELSE 0 END) AS qtdePontosPosit14, 
        sum(CASE WHEN QtdePontos > 0 AND diffDate <= 7  THEN QtdePontos ELSE 0 END) AS qtdePontosPosit7,

        -- 7. Pontos acumulados negativos (vida, D7, D14, D28, D56);
        sum(CASE WHEN QtdePontos < 0 THEN QtdePontos ELSE 0 END) qtdePontosNegVida,
        sum(CASE WHEN QtdePontos < 0 AND diffDate <= 56 THEN QtdePontos ELSE 0 END) AS qtdePontosNeg56, 
        sum(CASE WHEN QtdePontos < 0 AND diffDate <= 28 THEN QtdePontos ELSE 0 END) AS qtdePontosNeg28, 
        sum(CASE WHEN QtdePontos < 0 AND diffDate <= 14 THEN QtdePontos ELSE 0 END) AS qtdePontosNeg14, 
        sum(CASE WHEN QtdePontos < 0 AND diffDate <= 7  THEN QtdePontos ELSE 0 END) AS qtdePontosNeg7

    FROM tb_transacoes
    GROUP BY IdCliente
    ),

tb_transacao_produto AS (

    SELECT
        t1.*,
        t3.DescProduto,
        t3.DescCateogriaProduto
    FROM
    tb_transacoes t1

    LEFT JOIN transacao_produto t2
    ON t1.IdTransacao = t2.IdTransacao

    LEFT JOIN produtos t3
    ON t2.IdProduto = t3.IdProduto
    ),

tb_cliente_produto AS (

    -- 4. Produto mais usado (vida, D7, D14, D28, D56);
    SELECT
        IdCliente,
        DescProduto,
        count(*) AS qtdeVida,
        count(CASE WHEN diffDate <= 56 THEN IdTransacao END) as qtde56,
        count(CASE WHEN diffDate <= 28 THEN IdTransacao END) as qtde28,
        count(CASE WHEN diffDate <= 14 THEN IdTransacao END) as qtde14,
        count(CASE WHEN diffDate <= 7 THEN IdTransacao END) as  qtde7

    FROM tb_transacao_produto
    GROUP BY IdCliente, DescProduto
    ),

tb_cliente_produto_rn AS (

    SELECT
        *,
        row_number() OVER (PARTITION BY IdCliente ORDER BY qtdeVida DESC) AS rnVida,
        row_number() OVER (PARTITION BY IdCliente ORDER BY qtde56 DESC) AS rn56,
        row_number() OVER (PARTITION BY IdCliente ORDER BY qtde28 DESC) AS rn28,
        row_number() OVER (PARTITION BY IdCliente ORDER BY qtde14 DESC) AS rn14,
        row_number() OVER (PARTITION BY IdCliente ORDER BY qtde7 DESC) AS rn7

    FROM
    tb_cliente_produto
    ),

tb_cliente_dia AS (
    -- 8. Dias da semana mais ativos (D28)
    SELECT
        IdCliente,
        strftime('%w', DtCriacao) AS dtDia,
        count(IdTransacao) as qtdeTransacoes
    FROM
    tb_transacoes

    WHERE diffDate <= 28

    GROUP BY IdCliente, dtDia
    ),

tb_cliente_dia_rn AS (

    SELECT 
    *,
    row_number() OVER (PARTITION BY IdCliente ORDER BY qtdeTransacoes DESC) as rnDia

    FROM tb_cliente_dia
    ),

tb_join AS (

    SELECT

        t1.*,
        t2.idadeBase,
        t3.DescProduto as produtoVida,
        t4.DescProduto as produtoV56,
        t5.DescProduto as produto28,
        t6.DescProduto as produto14,
        t7.DescProduto as produto7,
        coalesce(t8.dtDia, -1) AS dtDia
    
    FROM tb_sumario_transacoes t1

    LEFT JOIN tb_cliente t2
    ON t1.IdCliente = t2.IdCliente

    LEFT JOIN tb_cliente_produto_rn t3
    ON t1.IdCliente = t3.IdCliente
    AND t3.rnVida = 1

    LEFT JOIN tb_cliente_produto_rn t4
    ON t1.IdCliente = t4.IdCliente
    AND t4.rn56 = 1

    LEFT JOIN tb_cliente_produto_rn t5
    ON t1.IdCliente = t5.IdCliente
    AND t5.rn28 = 1

    LEFT JOIN tb_cliente_produto_rn t6
    ON t1.IdCliente = t6.IdCliente
    AND t6.rn14 = 1

    LEFT JOIN tb_cliente_produto_rn t7
    ON t1.IdCliente = t7.IdCliente
    AND t7.rn7 = 1

    LEFT JOIN tb_cliente_dia_rn t8
    ON t1.IdCliente = t8.IdCliente
    AND t8.rnDia = 1
    )

SELECT * FROM tb_join