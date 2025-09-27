CREATE VIEW vGrupo
AS
	SELECT G.Id, G.Grupo, G.IdCampeonato, C.Campeonato
		FROM Grupo G
			JOIN Campeonato C ON G.IdCampeonato=C.Id;
GO


CREATE VIEW vEncuentro
AS
	SELECT E.Fecha, E.IdPais1, P1.Pais Pais1, E.Goles1, E.IdPais2, P2.Pais Pais2, E.Goles2,
        C.Campeonato, E.IdCampeonato, E.IdFase, F.Fase, ES.Estadio, E.IdEStadio
		FROM Encuentro E
			JOIN Pais P1 ON E.IdPais1=P1.Id
			JOIN Pais P2 ON E.IdPais2=P2.Id
			JOIN Campeonato C ON E.IdCampeonato=C.Id
            JOIN Estadio ES ON E.IdEstadio=ES.Id
            JOIN Fase F ON E.IdFase=F.Id;
GO		


CREATE VIEW vGrupoPais
AS
    SELECT GP.IdGrupo, G.Grupo, GP.IdPais, P.Pais
        FROM GrupoPais GP
            JOIN Pais P ON GP.IdPais=P.Id
			JOIN Grupo G ON GP.IdGrupo=G.Id
GO

--vista para identificar y mostrar los encuentros repetidos
CREATE VIEW vEncuentrosRepetidos
AS
    SELECT E1.IdCampeonato, C.Campeonato, E1.IdFase, F.Fase, E1.IdPais1 PaisMenor, E1.IdPais2 PaisMayor, COUNT(*) VecesRegistrado
		FROM Encuentro E1
			JOIN Campeonato C ON E1.IdCampeonato = C.Id
			JOIN Fase F ON E1.IdFase = F.Id
			JOIN Encuentro E2 ON E1.IdCampeonato = E2.IdCampeonato
                         AND E1.IdFase = E2.IdFase
                         AND (
                             (E1.IdPais1 = E2.IdPais1 AND E1.IdPais2 = E2.IdPais2) OR
                             (E1.IdPais1 = E2.IdPais2 AND E1.IdPais2 = E2.IdPais1)
                         )
		GROUP BY E1.IdCampeonato, C.Campeonato, E1.IdFase, F.Fase, E1.IdPais1, E1.IdPais2
		HAVING COUNT(*) > 1;
GO


--vista para visualizar los encuentros unicos (encuentros no repetidos)
CREATE VIEW vEncuentroDetallado
AS
    SELECT E.Id, C.Campeonato, F.Fase, P1.Pais Pais1, P2.Pais Pais2, E.Fecha, ES.Estadio, E.Goles1, E.Goles2
		FROM Encuentro E
			JOIN Pais P1 ON E.IdPais1=P1.Id
			JOIN Pais P2 ON E.IdPais2=P2.Id
			JOIN Campeonato C ON E.IdCampeonato=C.Id
			JOIN Estadio ES ON E.IdEstadio=ES.Id
			JOIN Fase F ON E.IdFase=F.Id;
GO

