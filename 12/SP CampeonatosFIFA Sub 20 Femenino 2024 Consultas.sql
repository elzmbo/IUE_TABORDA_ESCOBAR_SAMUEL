-- Ver los datos de la tabla temporal antes de generar los encuentros
SELECT * FROM #tmpGrupos;


EXEC spGenerarEncuentrosOctavos_FIFA_U20_Women_2024;


SELECT 
    e.Id AS EncuentroID,
    p1.Nombre AS Pais1,
    p2.Nombre AS Pais2,
    f.Fase,
    c.Campeonato,
    e.Fecha,
    e.IdEstadio
FROM Encuentro e
JOIN Pais p1 ON e.IdPais1 = p1.Id
JOIN Pais p2 ON e.IdPais2 = p2.Id
JOIN Fase f ON e.IdFase = f.Id
JOIN Campeonato c ON e.IdCampeonato = c.Id
WHERE c.Campeonato = 'FIFA U-20 Women''s World Cup Colombia 2024'
  AND f.Fase = 'Octavos de Final'
ORDER BY e.Fecha;





