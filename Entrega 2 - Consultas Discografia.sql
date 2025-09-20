-- a) canciones que ha compuesto 'JUANES'
SELECT COUNT(*) TotalCanciones
	FROM CancionCompositor CC
		JOIN Compositor C ON CC.IdCompositor = C.Id
	WHERE CHARINDEX('JUANES', C.Nombre) > 0


-- b) interpretaciones que se tienen de la canción "Lluvia" y sus diferentes ritmos
SELECT CA.Titulo, I.Nombre, R.Ritmo
	FROM Interpretacion IT
		JOIN Cancion CA ON IT.IdCancion = CA.Id
		JOIN Interprete I ON IT.IdInterprete = I.Id
		JOIN Ritmo R ON IT.IdRitmo = R.Id
	WHERE CA.Titulo = 'Lluvia'


-- c) canciones con el mismo Interprete y Compositor del ritmo 'Balada'
SELECT CA.Titulo, I.Nombre, C.Nombre
	FROM Interpretacion IT
		JOIN Cancion CA ON IT.IdCancion = CA.Id
		JOIN Interprete I ON IT.IdInterprete = I.Id
		JOIN Ritmo R ON IT.IdRitmo = R.Id
		JOIN CancionCompositor CC ON CA.Id = CC.IdCancion
		JOIN Compositor C ON CC.IdCompositor = C.Id
	WHERE R.Ritmo = 'Balada'
		AND CHARINDEX(I.Nombre, C.Nombre) > 0


-- d) lista de los paises que tienen grupos de ritmo 'Salsa'
SELECT DISTINCT P.Pais
	FROM Interprete I
		JOIN Pais P ON I.IdPais = P.Id
		JOIN Interpretacion IT ON IT.IdInterprete = I.Id
		JOIN Ritmo R ON IT.IdRitmo = R.Id
		JOIN Tipo T ON I.IdTipo = T.Id
	WHERE R.Ritmo = 'Salsa'
  		AND T.Tipo = 'Grupo';


-- e) artistas que interpretan las canciones 'Candilejas' y 'Malaguena'?
SELECT CA.Titulo Cancion, 
             I.Nombre Interprete
	FROM Cancion CA
		JOIN Interpretacion IT ON CA.Id = IT.IdCancion
		JOIN Interprete I ON IT.IdInterprete = I.Id
	WHERE CA.Titulo IN ('Candilejas', 'Malaguena')


-- f) lista de artistas que son interpretes y compositores a la vez y cuantas canciones tienen
SELECT I.Nombre Artista,
	COUNT(DISTINCT CC.IdCancion) TotalCompuestas, 
	COUNT(DISTINCT IT.IdCancion) TotalInterpretadas
	FROM Interprete I
		JOIN Compositor C ON CHARINDEX(I.Nombre, C.Nombre) > 0
		JOIN CancionCompositor CC ON C.Id = CC.IdCompositor
		JOIN Interpretacion IT ON I.Id = IT.IdInterprete
	GROUP BY I.Nombre
