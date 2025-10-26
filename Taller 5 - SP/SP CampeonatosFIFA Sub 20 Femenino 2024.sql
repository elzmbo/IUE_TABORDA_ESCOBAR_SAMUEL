CREATE PROCEDURE spGenerarEncuentros
    @IdGrupo INT
    @IdEstadio INT
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @IdCampeonato INT,
            @IdFase INT,
            @PrimeroG1 INT,
            @SegundoG1 INT,
            @PrimeroG2 INT,
            @SegundoG2 INT;

    -- para obtener el id del campeonato
    SELECT @IdCampeonato = Id
    FROM Campeonato
    WHERE Campeonato = 'FIFA U-20 Women''s World Cup Colombia 2024';

    IF @IdCampeonato IS NULL
    BEGIN
        PRINT 'No se encontró el campeonato FIFA U-20 Women''s World Cup Colombia 2024';
        RETURN;
    END

    -- si se ha proporcionado el IdGrupo, se generarán los encuentros para ese grupo
    IF @IdGrupo IS NOT NULL
    BEGIN
        -- validar que existan países en el grupo
        IF NOT EXISTS (SELECT 1 FROM GrupoPais WHERE IdGrupo = @IdGrupo)
        BEGIN
            RAISERROR('El grupo no tiene países asignados.', 16, 1);
            RETURN;
        END;

        -- CTE para listar los países del grupo
        WITH PaisesGrupo AS (
            SELECT IdPais
            FROM GrupoPais
            WHERE IdGrupo = @IdGrupo
        ),
        -- CTE para generar combinaciones de todos contra todos
        Combinaciones AS(
            SELECT P1.IdPais AS IdPais1,
                   P2.IdPais AS IdPais2
            FROM PaisesGrupo P1
                CROSS JOIN PaisesGrupo P2
            WHERE P1.IdPais < P2.IdPais
        )
        -- insertar los encuentros que no existen
        INSERT INTO Encuentro
            (IdPais1, IdPais2, IdFase, IdCampeonato, IdEstadio)
        SELECT C.IdPais1, C.IdPais2, 1, @IdCampeonato, @IdEstadio
        FROM Combinaciones C;

        PRINT 'Encuentros generados correctamente para el grupo ' + CAST(@IdGrupo AS VARCHAR);
    END
    ELSE
    BEGIN

        -- generar Encuentros para Octavos de Final

        -- crear la fase de Octavos si no existe
        SELECT @IdFase = Id FROM Fase WHERE Fase = 'Octavos de Final';
        IF @IdFase IS NULL
        BEGIN
            INSERT INTO Fase (Fase) VALUES ('Octavos de Final');
            SET @IdFase = SCOPE_IDENTITY();
        END

        -- Seleccionar un estadio (por ejemplo, el primero en la lista)
        SELECT TOP 1 @IdEstadio = Id FROM Estadio ORDER BY Id;


        -- crear tabla temporal para obtener los primeros y segundos lugares de cada grupo
        SELECT 
            g1.Id AS Grupo1, g2.Id AS Grupo2,
            -- Obtenemos los equipos del grupo1
            (SELECT TOP 1 IdPais FROM GrupoPais WHERE IdGrupo = g1.Id ORDER BY IdPais) AS PrimeroG1,
            (SELECT TOP 1 IdPais FROM GrupoPais WHERE IdGrupo = g1.Id ORDER BY IdPais DESC) AS SegundoG1,
            -- Obtenemos los equipos del grupo2
            (SELECT TOP 1 IdPais FROM GrupoPais WHERE IdGrupo = g2.Id ORDER BY IdPais) AS PrimeroG2,
            (SELECT TOP 1 IdPais FROM GrupoPais WHERE IdGrupo = g2.Id ORDER BY IdPais DESC) AS SegundoG2
        INTO #GruposTemporales
        FROM Grupo g1
        JOIN Grupo g2 ON g2.Id = g1.Id + 1
        WHERE g1.IdCampeonato = @IdCampeonato;


        -- genera los encuentros entre los primeros y segundos lugares de los grupos
        -- Encuentro 1° grupo1 vs 2° grupo2

        INSERT INTO Encuentro (IdPais1, IdPais2, IdFase, IdCampeonato, IdEstadio, Fecha)
        SELECT 
            PrimeroG1, SegundoG2, @IdFase, @IdCampeonato, @IdEstadio, GETDATE()
        FROM #GruposTemporales
        WHERE NOT EXISTS (
            SELECT 1 FROM Encuentro
            WHERE IdCampeonato = @IdCampeonato AND IdFase = @IdFase 
            AND IdPais1 = PrimeroG1 AND IdPais2 = SegundoG2
        );


        -- Encuentro 2° grupo1 vs 1° grupo2

        INSERT INTO Encuentro (IdPais1, IdPais2, IdFase, IdCampeonato, IdEstadio, Fecha)
        SELECT 
            SegundoG1, PrimeroG2, @IdFase, @IdCampeonato, @IdEstadio, GETDATE()
        FROM #GruposTemporales
        WHERE NOT EXISTS (
            SELECT 1 FROM Encuentro
            WHERE IdCampeonato = @IdCampeonato AND IdFase = @IdFase 
            AND IdPais1 = SegundoG1 AND IdPais2 = PrimeroG2
        );

        -- limpiar tabla temporal
        DROP TABLE #GruposTemporales;

        PRINT 'Encuentros de Octavos de Final generados correctamente para el campeonato FIFA U-20 Women''s World Cup Colombia 2024';
    END
END
GO
