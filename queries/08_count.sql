SELECT  count(*) AS TotalClientes,
        count(1) AS TotalClientes2,
        count(IdCliente) AS TotalClientesComId,
        count(DtCriacao) AS TotalClientesComDtCriacao,
        count(DtAtualizacao) AS TotalClientesComDtAtualizacao
FROM clientes;