-- INNER JOIN
SELECT P.IdPedido, U.Nombre AS Cliente
FROM Pedido P
INNER JOIN Usuario U ON P.IdCliente = U.IdUsuario;

-------------------------------------------------
-- LEFT JOIN
SELECT U.Nombre, P.IdPedido
FROM Usuario U
LEFT JOIN Pedido P ON U.IdUsuario = P.IdCliente;

-------------------------------------------------
-- RIGHT JOIN
SELECT P.IdPedido, U.Nombre
FROM Pedido P
RIGHT JOIN Usuario U ON P.IdCliente = U.IdUsuario;

-------------------------------------------------
-- INNER JOIN con 3 tablas
SELECT P.IdPedido, U.Nombre, PR.Nombre AS Producto
FROM Pedido P
INNER JOIN Usuario U ON P.IdCliente = U.IdUsuario
INNER JOIN DetallePedido D ON P.IdPedido = D.IdPedido
INNER JOIN Producto PR ON D.IdProducto = PR.IdProducto;

-------------------------------------------------
-- HAVING
SELECT IdCliente, COUNT(IdPedido) AS TotalPedidos
FROM Pedido
GROUP BY IdCliente
HAVING COUNT(IdPedido) > 1;




-- HAVING
SELECT U.Nombre, COUNT(P.IdPedido) AS TotalPedidos
FROM Usuario U
INNER JOIN Pedido P ON U.IdUsuario = P.IdCliente
GROUP BY U.Nombre
HAVING COUNT(P.IdPedido) > 1;


SELECT C.Nombre, SUM(D.Subtotal) AS TotalVentas
FROM Comercio C
INNER JOIN Producto PR ON C.IdComercio = PR.IdComercio
INNER JOIN DetallePedido D ON PR.IdProducto = D.IdProducto
GROUP BY C.Nombre;

SELECT U.Nombre, COUNT(P.IdPedido) AS Entregas
FROM Usuario U
INNER JOIN Pedido P ON U.IdUsuario = P.IdRepartidor
WHERE P.Estado = 'Entregado'
GROUP BY U.Nombre
ORDER BY Entregas DESC;

SELECT TOP 1 *
FROM Pedido
ORDER BY Total DESC;


