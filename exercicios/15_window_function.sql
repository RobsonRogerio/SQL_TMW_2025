-- Quantidade de usuários cadastrados (absoluto e acumulado) ao longo do tempo?

WITH tb_qtd_dia AS (

    SELECT
        substr(DtCriacao, 1, 10) dtDia,
        count(IdCliente) as qtdeClientes
    FROM clientes
    GROUP BY dtDia
    ),

tb_cadastros_total AS (

    SELECT
        count(IdCliente) AS ttlClientes
    FROM clientes
    )


SELECT
    *,
    sum(qtdeClientes) OVER (ORDER BY dtDia) AS ttlAcum
FROM tb_qtd_dia