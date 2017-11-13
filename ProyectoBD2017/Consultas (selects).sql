/* 9. La BD debe realizar al menos una consulta que involucre una relación 1:N. */

SELECT NumeroCompra, FechaCompra, Ubicacion as Sucursal, 
CedulaV as Vendedor, CedulaC as Cliente FROM Compra;

/* 10. La BD debe realizar al menos una consulta que involucre una relación N:M. */

SELECT * FROM Atiende;

SELECT * FROM Trabaja_En;

/* 11. La BD debe realizar al menos una consulta sobre dos tablas usando join. */ 

SELECT p.Cedula, p.NombreP, p.PrimerApellido, p.SegundoApellido, t.Ubicacion as Trabaja_En
FROM Trabaja_En t INNER JOIN Persona p on t.Cedula = p.Cedula;

/* 12. La BD debe realizar al menos una consulta que use group by. */

SELECT Cedula, AVG(Salario) AS SalarioVendedor
FROM Vendedor 
GROUP BY Cedula
ORDER BY Cedula DESC;