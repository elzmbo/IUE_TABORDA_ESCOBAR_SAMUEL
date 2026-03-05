-- Crear Base de Datos
CREATE DATABASE RappiApp;
GO

USE RappiApp;
GO

-- Tabla Usuario
CREATE TABLE Usuario (
    IdUsuario INT PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(100),
    Email VARCHAR(100),
    Telefono VARCHAR(20),
    Direccion VARCHAR(200),
    TipoUsuario VARCHAR(20) -- Cliente o Repartidor
);

-- Tabla Comercio
CREATE TABLE Comercio (
    IdComercio INT PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(100),
    Direccion VARCHAR(200),
    Telefono VARCHAR(20)
);

-- Tabla Producto
CREATE TABLE Producto (
    IdProducto INT PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(100),
    Precio DECIMAL(10,2),
    IdComercio INT,
    FOREIGN KEY (IdComercio) REFERENCES Comercio(IdComercio)
);

-- Tabla Pedido
CREATE TABLE Pedido (
    IdPedido INT PRIMARY KEY IDENTITY(1,1),
    Fecha DATETIME DEFAULT GETDATE(),
    Total DECIMAL(10,2),
    Estado VARCHAR(50),
    IdCliente INT,
    IdRepartidor INT,
    FOREIGN KEY (IdCliente) REFERENCES Usuario(IdUsuario),
    FOREIGN KEY (IdRepartidor) REFERENCES Usuario(IdUsuario)
);

-- Tabla DetallePedido
CREATE TABLE DetallePedido (
    IdDetalle INT PRIMARY KEY IDENTITY(1,1),
    IdPedido INT,
    IdProducto INT,
    Cantidad INT,
    Subtotal DECIMAL(10,2),
    FOREIGN KEY (IdPedido) REFERENCES Pedido(IdPedido),
    FOREIGN KEY (IdProducto) REFERENCES Producto(IdProducto)
);

-- Índice único (1 solo índice solicitado)
CREATE INDEX IX_Usuario_Email
ON Usuario(Email);