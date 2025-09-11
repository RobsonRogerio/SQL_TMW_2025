-- 8. Saldo de pontos acumulado de cada usuário

WITH tb_pontos_positivos AS (
    SELECT
        IdCliente,
        sum(QtdePontos) as QtdePontosPos
    FROM
    transacoes
    WHERE QtdePontos > 0
    GROUP BY IdCliente
    ),

tb_pontos_negativos AS (
    SELECT
        IdCliente,
        sum(QtdePontos) as QtdePontosNeg
    FROM
    transacoes
    WHERE QtdePontos <= 0
    GROUP BY IdCliente
    )

SELECT 

    t1.IdCliente,
    t1.QtdePontosPos,
    CASE
        WHEN t2.QtdePontosNeg ISNULL THEN
            coalesce(t2.QtdePontosNeg, 0) 
            ELSE t2.QtdePontosNeg 
    END AS QtdePontosNeg,
    
    (t1.QtdePontosPos + coalesce(t2.QtdePontosNeg, 0)) AS Saldo

FROM tb_pontos_positivos t1

LEFT JOIN tb_pontos_negativos t2
ON t1.IdCliente = t2.IdCliente;

-- Outra maneira de fazer:

WITH tb_clientes_dia AS (
    SELECT
        IdCliente,
        substr(DtCriacao,1,10) as dtDia,
        sum(QtdePontos) as movPontos
    FROM transacoes
    GROUP BY IdCliente, dtDia
    )

SELECT *,
        sum(movPontos) OVER (PARTITION BY IdCliente ORDER BY dtDia) AS saldoPontos
FROM tb_clientes_dia;