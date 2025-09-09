
-- 8. Lista de transações com o produto “Resgatar Ponei”;

SELECT tp.IdTransacao,
        p.IdProduto,
        p.DescProduto
FROM transacao_produto tp
LEFT JOIN produtos p
ON tp.IdProduto = p.IdProduto
WHERE p.DescProduto = 'Resgatar Ponei';

--*********************************************--

SELECT *

FROM transacao_produto AS t1

WHERE t1.IdProduto IN (
    SELECT IdProduto
    FROM produtos
    WHERE DescProduto = 'Resgatar Ponei'
);