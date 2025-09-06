SELECT

    sum(CASE
        WHEN QtdePontos > 0 THEN QtdePontos
    END) as PontosGanhos,

    sum(CASE
        WHEN QtdePontos < 0 THEN QtdePontos
    END) as PontosPerdidos,

    sum(QtdePontos) as SaldoPontos,

    count(CASE
        WHEN QtdePontos < 0 THEN QtdePontos
    END) as QtdeTransacoesNegativas

FROM transacoes

WHERE DtCriacao >= '2025-07-01'
  AND DtCriacao < '2025-08-01'

ORDER BY QtdePontos;