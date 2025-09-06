SELECT  IdCliente,
        QtdePontos,
        CASE
            WHEN QtdePontos > 10000 THEN 'Mago Sumpremo'
            WHEN QtdePontos > 5000 THEN 'Mago Mestre'
            WHEN QtdePontos > 1000 THEN 'Mago Aprendiz'
            WHEN QtdePontos > 500 THEN 'Ponei Premium'
            ELSE 'Ponei'
        END AS Categoria,

        CASE
            WHEN QtdePontos <= 1000 THEN 1
            ELSE 0
        END AS flPonei,

        CASE
            WHEN QtdePontos > 1000 THEN 1
            ELSE 0
        END AS flMago

FROM clientes;