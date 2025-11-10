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

    -- Elimina los espacios al principio y al final de la frase
    SET @Frase = LTRIM(RTRIM(@Frase));

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
        LTRIM(RTRIM(p.value)) AS PalabraOriginal, 
        LTRIM(RTRIM(t.Texto)) AS Traduccion      
    FROM STRING_SPLIT(@Frase, ' ') p
    JOIN Frase f ON f.Texto = LTRIM(RTRIM(p.value))  
    JOIN Traduccion t ON t.IdFrase = f.Id AND t.IdIdioma = @IdIdioma
    WHERE LTRIM(RTRIM(p.value)) <> '';  

    RETURN;
END
GO
