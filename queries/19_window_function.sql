WITH tb_cliente_dia AS (
    SELECT
        IdCliente,
        substr(DtCriacao, 1, 10) as dtDia,
        count(DISTINCT IdTransacao) as qtdeTransacoes
    FROM transacoes
    WHERE dtCriacao >= '2025-08-25'
    AND DtCriacao < '2025-08-30'
    GROUP BY IdCliente, dtDia
    ),

tb_lag as (

    SELECT 
        *,
        sum(qtdeTransacoes) OVER (PARTITION BY IdCliente ORDER BY dtDia) AS acumulado,
        lag(qtdeTransacoes) OVER (PARTITION BY IdCliente ORDER BY dtDia) AS lag
    FROM tb_cliente_dia
    )

SELECT

*,
round(1. * qtdeTransacoes / lag, 2) AS variacao

FROM tb_lag