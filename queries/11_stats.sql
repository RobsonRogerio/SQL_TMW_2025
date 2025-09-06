SELECT

    avg(QtdePontos) as MediaPontos,
    1. * sum(QtdePontos) / count(IdCliente) as MediaPontosPorCliente,
    min(QtdePontos) as MinimoPontos,
    max(QtdePontos) as MaximoPontos,
    sum(FlTwitch) as TotalClientesTwitch,
    sum(FlEmail) as TotalClientesEmail

FROM clientes