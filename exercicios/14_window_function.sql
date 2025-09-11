--5. Quantidade de transações Acumuladas ao longo do tempo?

WITH tb_qtd_transacoes_dia AS (
    SELECT
        substr(DtCriacao, 1, 10) as dtDia,
        count(IdTransacao) as qtdeTransacoes
    FROM transacoes
    GROUP BY dtDia
    ORDER BY dtDia
    )

SELECT    
    *,
    sum(qtdeTransacoes) OVER (PARTITION BY 1 ORDER BY dtDia) AS AcumTransacoes
FROM tb_qtd_transacoes_dia;

-- PARTITION BY 1 → significa que não haverá particionamento real. 
-- O 1 é apenas um valor constante, então todas as linhas pertencem à mesma partição.

-- 👉 Em outras palavras, usar PARTITION BY 1 tem o mesmo efeito que não usar PARTITION BY.
-- O resultado é um acumulado global de qtdeTransacoes ao longo do tempo (anoMes).

-- ⚠️ O uso de PARTITION BY 1 muitas vezes aparece em queries por “força do hábito” 
-- ou para deixar explícito que não existe particionamento, mas não muda nada em
-- relação a simplesmente não usar PARTITION BY.

-- 👉 Resumindo: não existe diferença entre PARTITION BY 1, PARTITION BY 2, etc.
-- Todos significam "sem particionamento".