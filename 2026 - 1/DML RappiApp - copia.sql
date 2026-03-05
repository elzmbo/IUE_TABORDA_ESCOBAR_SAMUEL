-- INSERT (Create)

INSERT INTO Usuario (Nombre, Email, Telefono, Direccion, TipoUsuario)
VALUES 
('Carlos Perez','carlos@gmail.com','3001111111','Medellin','Cliente'),
('Ana Gomez','ana@gmail.com','3002222222','Medellin','Repartidor');
('Juan Ramirez','juan@gmail.com','3001110001','Medellin','Cliente'),
('Laura Martinez','laura@gmail.com','3001110002','Bogota','Cliente'),
('Andres Torres','andres@gmail.com','3001110003','Cali','Cliente'),
('Sofia Lopez','sofia@gmail.com','3001110004','Barranquilla','Cliente'),
('Miguel Castro','miguel@gmail.com','3001110005','Cartagena','Cliente'),
('Carlos Rojas','carlosr@gmail.com','3012220001','Medellin','Repartidor'),
('Camila Diaz','camila@gmail.com','3012220002','Bogota','Repartidor'),
('Felipe Gomez','felipe@gmail.com','3012220003','Cali','Repartidor');


INSERT INTO Comercio (Nombre, Direccion, Telefono)
VALUES 
('Restaurante Paisa','Centro','4444444');
('Burger House','Medellin Centro','4441000'),
('Pizza Express','Bogota Norte','4442000'),
('Sushi Go','Cali Sur','4443000'),
('Tacos MX','Barranquilla','4444000'),
('Healthy Food','Cartagena','4445000');


INSERT INTO Producto (Nombre, Precio, IdComercio)
VALUES 
('Bandeja Paisa',25000,1);
('Hamburguesa Doble',18000,1),
('Papas Grandes',8000,1),
('Pizza Hawaiana',35000,2),
('Pizza Pepperoni',32000,2),
('Sushi 12 Piezas',40000,3),
('Combo Tacos x3',22000,4),
('Ensalada Fit',15000,5),
('Jugo Natural',7000,5);


INSERT INTO Pedido (Total, Estado, IdCliente, IdRepartidor)
VALUES 
(25000,'En proceso',1,2);
(26000,'En proceso',1,6),
(35000,'Entregado',2,7),
(40000,'En proceso',3,8),
(15000,'Cancelado',4,6),
(54000,'Entregado',1,7),
(22000,'En proceso',5,8);


INSERT INTO DetallePedido (IdPedido, IdProducto, Cantidad, Subtotal)
VALUES 
(1,1,1,25000);
(1,1,1,18000),
(1,2,1,8000),
(2,3,1,35000),
(3,5,1,40000),
(4,7,1,15000),
(5,1,2,36000),
(5,2,1,8000),
(5,8,1,7000),
(6,6,1,22000);


-------------------------------------------------
-- READ
SELECT * FROM Usuario;

-------------------------------------------------
-- UPDATE
UPDATE Pedido
SET Estado = 'Entregado'
WHERE IdPedido = 1;

-------------------------------------------------
-- DELETE
DELETE FROM DetallePedido
WHERE IdDetalle = 1;

-------------------------------------------------
-- TRUNCATE
TRUNCATE TABLE DetallePedido;