
DROP TABLE IF EXISTS relatorio_diario;

CREATE TABLE IF NOT EXISTS relatorio_diario AS

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
FROM tb_qtd_transacoes_dia
;

SELECT * FROM relatorio_diario;