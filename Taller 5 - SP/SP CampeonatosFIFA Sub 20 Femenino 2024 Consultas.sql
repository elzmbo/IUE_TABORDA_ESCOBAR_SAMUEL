SELECT * FROM Campeonato 

-- ver todos los encuentros generados
SELECT * FROM Encuentro WHERE IdCampeonato = (SELECT Id FROM Campeonato WHERE Campeonato = 'FIFA U-20 Women''s World Cup Colombia 2024');

WITH PaisesGrupo AS (
    SELECT IdPais
    FROM GrupoPais
    WHERE IdGrupo = 1 
),
Combinaciones AS(
    SELECT P1.IdPais AS IdPais1,
           P2.IdPais AS IdPais2
    FROM PaisesGrupo P1
    CROSS JOIN PaisesGrupo P2
    WHERE P1.IdPais < P2.IdPais
)
SELECT * FROM Combinaciones;


 --ver los primeros y segundos lugares de los grupos
SELECT 
    g1.Id AS Grupo1, g2.Id AS Grupo2,
    (SELECT TOP 1 IdPais FROM GrupoPais WHERE IdGrupo = g1.Id ORDER BY IdPais) AS PrimeroG1,
    (SELECT TOP 1 IdPais FROM GrupoPais WHERE IdGrupo = g1.Id ORDER BY IdPais DESC) AS SegundoG1,
    (SELECT TOP 1 IdPais FROM GrupoPais WHERE IdGrupo = g2.Id ORDER BY IdPais) AS PrimeroG2,
    (SELECT TOP 1 IdPais FROM GrupoPais WHERE IdGrupo = g2.Id ORDER BY IdPais DESC) AS SegundoG2
FROM Grupo g1
JOIN Grupo g2 ON g2.Id = g1.Id + 1
WHERE g1.IdCampeonato = (SELECT Id FROM Campeonato WHERE Campeonato = 'FIFA U-20 Women''s World Cup Colombia 2024');


EXEC spGenerarEncuentros @IdGrupo = 1, @IdEstadio = 1;

