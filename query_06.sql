-- Metricas dos canais de atendimento

SELECT canal, tempo_medio_atendimento, qntd, resolvidos, ROUND(resolvidos / CAST(qntd AS NUMERIC), 4) as taxa_de_resolucao, custo_total FROM (
  SELECT canal, ROUND(AVG(tempo_atendimento), 2) AS tempo_medio_atendimento, COUNT(canal) AS qntd,
    SUM(
      CASE 
				WHEN resolvido = 'Sim' THEN 1
				ELSE 0
			END	
    ) AS resolvidos,
		ROUND(SUM(CAST(REPLACE(custo, ',', '.') AS NUMERIC)), 2) as custo_total
	FROM chamados
	JOIN custos ON chamados.id_chamado = custos.id_chamado 
	GROUP BY canal
) AS subset ORDER BY tempo_medio_atendimento DESC;