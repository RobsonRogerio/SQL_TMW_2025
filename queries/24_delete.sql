DELETE FROM relatorio_diario
WHERE strftime('%w', dtDia) = '0';

SELECT * FROM relatorio_diario;
