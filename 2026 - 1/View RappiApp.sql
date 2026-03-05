-- Vista pedidos completos
CREATE VIEW VW_PedidosCompletos AS
SELECT 
    P.IdPedido,
    U.Nombre AS Cliente,
    UR.Nombre AS Repartidor,
    P.Total,
    P.Estado,
    P.Fecha
FROM Pedido P
INNER JOIN Usuario U ON P.IdCliente = U.IdUsuario
INNER JOIN Usuario UR ON P.IdRepartidor = UR.IdUsuario;

-------------------------------------------------

-- Vista productos por comercio
CREATE VIEW VW_ProductosComercio AS
SELECT 
    C.Nombre AS Comercio,
    P.Nombre AS Producto,
    P.Precio
FROM Producto P
INNER JOIN Comercio C ON P.IdComercio = C.IdComercio;