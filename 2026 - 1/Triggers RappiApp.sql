-- Trigger AFTER INSERT (ADD)
CREATE TRIGGER TR_CalcularTotal
ON DetallePedido
AFTER INSERT
AS
BEGIN
    UPDATE Pedido
    SET Total = (
        SELECT SUM(Subtotal)
        FROM DetallePedido
        WHERE IdPedido = inserted.IdPedido
    )
    FROM inserted
    WHERE Pedido.IdPedido = inserted.IdPedido;
END;
GO

-------------------------------------------------

-- Trigger AFTER UPDATE
CREATE TRIGGER TR_ActualizarEstado
ON Pedido
AFTER UPDATE
AS
BEGIN
    IF UPDATE(Estado)
    BEGIN
        PRINT 'El estado del pedido fue actualizado';
    END
END;
GO