USE CampeonatosFIFA
GO

CREATE PROCEDURE spGenerarEncuentrosOctavos_FIFA_U20_Women_2024
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @IdCampeonato INT,
            @IdFase INT,
            @IdEstadio INT,
            @IdGrupo1 INT,
            @IdGrupo2 INT,
            @PrimeroG1 INT,
            @SegundoG1 INT,
            @PrimeroG2 INT,
            @SegundoG2 INT;

    -- Obtener el campeonato
    SELECT @IdCampeonato = Id
    FROM Campeonato
    WHERE Campeonato = 'FIFA U-20 Women''s World Cup Colombia 2024';

    IF @IdCampeonato IS NULL
    BEGIN
        PRINT 'No se encontró el campeonato FIFA U-20 Women''s World Cup Colombia 2024';
        RETURN;
    END

    -- Obtener o crear la fase "Octavos de Final"
    SELECT @IdFase = Id FROM Fase WHERE Fase = 'Octavos de Final';
    IF @IdFase IS NULL
    BEGIN
        INSERT INTO Fase (Fase) VALUES ('Octavos de Final');
        SET @IdFase = SCOPE_IDENTITY();
    END

    -- Usar cualquier estadio disponible (puedes cambiarlo si lo deseas)
    SELECT TOP 1 @IdEstadio = Id FROM Estadio ORDER BY Id;

    -- Realizamos una consulta que simule el comportamiento del cursor
    -- para recorrer los grupos en pares (A con B, C con D, etc.)
    -- Utilizamos un JOIN para combinar los grupos en pares

    -- Generar encuentros para los grupos en pares (Grupo A con B, C con D, etc.)
    SELECT 
        g1.Id AS Grupo1, g2.Id AS Grupo2,
        -- Obtenemos los equipos del grupo1
        (SELECT TOP 1 IdPais FROM GrupoPais WHERE IdGrupo = g1.Id ORDER BY IdPais) AS PrimeroG1,
        (SELECT TOP 1 IdPais FROM GrupoPais WHERE IdGrupo = g1.Id ORDER BY IdPais DESC) AS SegundoG1,
        -- Obtenemos los equipos del grupo2
        (SELECT TOP 1 IdPais FROM GrupoPais WHERE IdGrupo = g2.Id ORDER BY IdPais) AS PrimeroG2,
        (SELECT TOP 1 IdPais FROM GrupoPais WHERE IdGrupo = g2.Id ORDER BY IdPais DESC) AS SegundoG2
    INTO #tmpGrupos
    FROM Grupo g1
    JOIN Grupo g2 ON g2.Id = g1.Id + 1
    WHERE g1.IdCampeonato = @IdCampeonato;

    -- Generar encuentros
    -- 1° grupo1 vs 2° grupo2
    INSERT INTO Encuentro (IdPais1, IdPais2, IdFase, IdCampeonato, IdEstadio, Fecha)
    SELECT 
        PrimeroG1, SegundoG2, @IdFase, @IdCampeonato, @IdEstadio, GETDATE()
    FROM #tmpGrupos
    WHERE NOT EXISTS (
        SELECT 1 FROM Encuentro
        WHERE IdCampeonato = @IdCampeonato AND IdFase = @IdFase 
        AND IdPais1 = PrimeroG1 AND IdPais2 = SegundoG2
    );

    -- 2° grupo1 vs 1° grupo2
    INSERT INTO Encuentro (IdPais1, IdPais2, IdFase, IdCampeonato, IdEstadio, Fecha)
    SELECT 
        SegundoG1, PrimeroG2, @IdFase, @IdCampeonato, @IdEstadio, GETDATE()
    FROM #tmpGrupos
    WHERE NOT EXISTS (
        SELECT 1 FROM Encuentro
        WHERE IdCampeonato = @IdCampeonato AND IdFase = @IdFase 
        AND IdPais1 = SegundoG1 AND IdPais2 = PrimeroG2
    );

    -- Limpiar tabla temporal
    DROP TABLE #tmpGrupos;

    PRINT 'Encuentros de Octavos de Final generados correctamente para el campeonato FIFA U-20 Women''s World Cup Colombia 2024';
END
GO
