SELECT IdCliente,
        QtdePontos,
        QtdePontos + 10 as PontosFuturos,
        QtdePontos * 2 as PontosDobro,
        DtCriacao,
        datetime(substr(DtCriacao, 1, 19)) as Date,
        strftime('%w', datetime(substr(DtCriacao, 1, 19))) as DiaSemana

FROM clientes