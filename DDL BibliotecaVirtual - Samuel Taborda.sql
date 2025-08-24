-- Crear la base de datos
CREATE DATABASE BibliotecaVirtual
GO

-- Ir a la base de datos
USE BibliotecaVirtual


-- Crear la tabla Pais
CREATE TABLE Pais (
	Id INT IDENTITY NOT NULL,
	Nombre VARCHAR(100) NOT NULL,
	CodigoAlfa VARCHAR(5) NOT NULL,
	Indicativo INT NOT NULL,
	CONSTRAINT pk_Pais_Id PRIMARY KEY(Id)
)


-- Crear indice de la tabla Pais
CREATE UNIQUE INDEX ix_Pais_Nombre 
	ON Pais(Nombre)
CREATE UNIQUE INDEX ix_Pais_CodigoAlfa 
	ON Pais(CodigoAlfa)


-- Crear la tabla Ciudad
CREATE TABLE Ciudad (
	Id INT IDENTITY NOT NULL,
	Nombre VARCHAR(100) NOT NULL,
	IdPais INT NOT NULL,
	CONSTRAINT pk_Ciudad_Id PRIMARY KEY (Id),
	CONSTRAINT fk_Ciudad_IdPais FOREIGN KEY (IdPais) REFERENCES Pais(Id)
)

-- Crear indice de la tabla Ciudad
CREATE UNIQUE INDEX ix_Ciudad_Nombre 
	ON Ciudad(IdPais, Nombre)


-- Crear la tabla Editorial
CREATE TABLE Editorial (
	Id INT IDENTITY NOT NULL,
	Nombre VARCHAR(100) NOT NULL,
	IdCiudad INT NOT NULL,
	CONSTRAINT pk_Editorial_Id PRIMARY KEY (Id),
	CONSTRAINT fk_Editorial_IdCiudad FOREIGN KEY (IdCiudad) REFERENCES Ciudad(Id)
)

-- Crear indice de la tabla Editorial
CREATE UNIQUE INDEX ix_Editorial_Nombre 
	ON Editorial(Nombre)


-- Crear la tabla Publicacion
CREATE TABLE Publicacion (
	Id INT IDENTITY NOT NULL,
	Titulo VARCHAR(200) NOT NULL,
	Descripcion VARCHAR(500) NULL,
	Año INT NOT NULL,
	Tipo VARCHAR(50) NOT NULL,
	Edicion VARCHAR(50) NULL,
	Volumen VARCHAR(20) NULL,
	Numero VARCHAR(20) NULL,
	ISSN VARCHAR(20) NULL,
	ISBN VARCHAR(20) NULL,
	Paginas INT NULL,
	Signatura VARCHAR(50) NULL,
	IdEditorial INT NOT NULL,
	CONSTRAINT pk_Publicacion_Id PRIMARY KEY (Id),
	CONSTRAINT fk_Publicacion_IdEditorial FOREIGN KEY (IdEditorial) REFERENCES Editorial(Id)
)

-- Crear indice de la tabla Publicacion
CREATE UNIQUE INDEX ix_Publicacion_Titulo 
	ON Publicacion(Titulo)


-- Crear la tabla Autor
CREATE TABLE Autor (
	Id INT IDENTITY NOT NULL,
	Nombre VARCHAR(200) NOT NULL,
	TipoAutor VARCHAR(50) NOT NULL,
	IdPais INT NOT NULL,
	CONSTRAINT pk_Autor_Id PRIMARY KEY (Id),
	CONSTRAINT fk_Autor_IdPais FOREIGN KEY (IdPais) REFERENCES Pais(Id)
)

-- Crear indice de la tabla Autor
CREATE UNIQUE INDEX ix_Autor_Nombre 
	ON Autor(Nombre)


-- Crear la tabla PublicacionAutor
CREATE TABLE PublicacionAutor (
	IdPublicacion INT NOT NULL,
	IdAutor INT NOT NULL,
	Rol VARCHAR(50) NULL,
	CONSTRAINT pk_PublicacionAutor PRIMARY KEY (IdPublicacion, IdAutor),
	CONSTRAINT fk_PublicacionAutor_IdPublicacion FOREIGN KEY (IdPublicacion) REFERENCES Publicacion(Id),
	CONSTRAINT fk_PublicacionAutor_IdAutor FOREIGN KEY (IdAutor) REFERENCES Autor(Id)
)


-- Crear la tabla Tema
CREATE TABLE Tema (
	Id INT IDENTITY NOT NULL,
	Nombre VARCHAR(100) NOT NULL,
	CONSTRAINT pk_Tema_Id PRIMARY KEY (Id)
)

-- Crear indice de la tabla Tema
CREATE UNIQUE INDEX ix_Tema_Nombre 
	ON Tema(Nombre)


-- Crear la tabla PublicacionTema
CREATE TABLE PublicacionTema (
	IdPublicacion INT NOT NULL,
	IdTema INT NOT NULL,
	CONSTRAINT pk_PublicacionTema PRIMARY KEY (IdPublicacion, IdTema),
	CONSTRAINT fk_PublicacionTema_IdPublicacion FOREIGN KEY (IdPublicacion) REFERENCES Publicacion(Id),
	CONSTRAINT fk_PublicacionTema_IdTema FOREIGN KEY (IdTema) REFERENCES Tema(Id)
)


-- Crear la tabla Ejemplar
CREATE TABLE Ejemplar (
	Id INT IDENTITY NOT NULL,
	IdPublicacion INT NOT NULL,
	CodigoBarras VARCHAR(100) UNIQUE,
	Estado VARCHAR(50) DEFAULT 'Disponible',
	Ubicacion VARCHAR(100) NULL,
	CONSTRAINT pk_Ejemplar_Id PRIMARY KEY (Id),
	CONSTRAINT fk_Ejemplar_IdPublicacion FOREIGN KEY (IdPublicacion) REFERENCES Publicacion(Id)
)

