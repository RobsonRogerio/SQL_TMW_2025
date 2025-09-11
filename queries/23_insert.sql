
DELETE FROM relatorio_diario;

WITH tb_qtd_transacoes_dia AS (
    SELECT
        substr(DtCriacao, 1, 10) as dtDia,
        count(IdTransacao) as qtdeTransacoes
    FROM transacoes
    GROUP BY dtDia
    ORDER BY dtDia
    ),

tb_acum AS (

    SELECT    
        *,
        sum(qtdeTransacoes) OVER (PARTITION BY 1 ORDER BY dtDia) AS AcumTransacoes
    FROM tb_qtd_transacoes_dia
    )

INSERT INTO relatorio_diario

SELECT * FROM tb_acum;

SELECT count(*) FROM relatorio_diario;

SELECT * FROM relatorio_diario;