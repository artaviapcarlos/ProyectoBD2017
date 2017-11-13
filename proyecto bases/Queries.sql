use BD_OutletAntiguedadesColonial;

-- Queries

-- 1 a N: Consigue el nombre de los productos que se compraron el mismo día que llegaron a la tienda.
SELECT Nombre
FROM Producto JOIN Compra
ON CONVERT(varchar(20),Fecha, 103) = CONVERT(varchar(20),FechaCompra, 103)
