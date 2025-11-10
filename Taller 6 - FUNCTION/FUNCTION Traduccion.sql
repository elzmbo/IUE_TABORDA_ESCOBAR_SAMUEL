USE Traduccion
GO

CREATE FUNCTION fTraducirFrase(
    @Frase NVARCHAR(255),
    @IdiomaDestino NVARCHAR(50)
)
RETURNS @Resultado TABLE (
    PalabraOriginal NVARCHAR(255),
    Traduccion NVARCHAR(255)
)
AS
BEGIN
    DECLARE @IdIdioma INT;

    -- Busca el id del idioma destino
    SELECT @IdIdioma = Id
    FROM Idioma
    WHERE Idioma = @IdiomaDestino;

    -- Verifica si el idioma existe
    IF @IdIdioma IS NULL
    BEGIN
        RAISERROR('El idioma especificado no existe en la base de datos.', 16, 1);
        RETURN;
    END;

    -- Resultado de la traduccion
    INSERT INTO @Resultado
    SELECT 
        p.value AS PalabraOriginal,
        t.Texto AS Traduccion
    FROM STRING_SPLIT(@Frase, ' ') p
    JOIN Frase f ON f.Texto = p.value
    JOIN Traduccion t ON t.IdFrase = f.Id AND t.IdIdioma = @IdIdioma
    WHERE p.value <> ''; 

    RETURN;
END
GO
