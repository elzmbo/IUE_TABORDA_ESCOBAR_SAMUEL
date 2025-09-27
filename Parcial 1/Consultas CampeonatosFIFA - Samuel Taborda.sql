SELECT * FROM vGrupo
SELECT * FROM Grupo

SELECT * FROM vGrupoPais
	WHERE IdGrupo IN (19, 20, 21, 22,23, 24)
	ORDER BY Grupo, Pais

INSERT INTO GrupoPais
	(IdGrupo, IdPais)
	VALUES(18, 1)

--para buscar un encuentro en el que se repite Pais (el cual no encuentra por la condicion del TRIGGER)
SELECT * FROM vEncuentro
	WHERE IdCampeonato=10
	AND (Pais1='Colombia' OR Pais2='Colombia')

--consulta de prueba del TRIGGER de Pais por Grupo
SELECT * FROM vGrupo
	WHERE IdCampeonato=9

--para buscar los encuentros repetidos para asi validar de que si funciona el TRIGGER
SELECT * FROM vEncuentrosRepetidos

--lista de encuentros de partidos unicos
SELECT * FROM vEncuentroDetallado
	
	