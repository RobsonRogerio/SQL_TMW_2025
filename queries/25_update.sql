SELECT 
*
FROM relatorio_diario;

-- update

UPDATE relatorio_diario
SET qtdeTransacoes = 10000
WHERE dtDia > '2025-08-25';

SELECT 
*
FROM relatorio_diario
ORDER BY dtDia DESC;