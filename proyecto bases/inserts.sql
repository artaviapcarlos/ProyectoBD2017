use BD_OutletAntiguedadesColonial;



-- Inserts Personas
INSERT INTO Persona VALUES ('403165495', 'Sergio', 'Chavarria', 'Ortega', 'sergio.chavarria@gmail.com', 'M', '1982-04-23', 'Mingo');
INSERT INTO Persona VALUES ('116390735', 'Jose', 'Artavia', 'Moya', 'jose.artavia@gmail.com', 'M', '1996-04-23', 'Mingo');
INSERT INTO Persona VALUES ('106070931', 'Andrés', 'Conejo', 'Chaves', 'andres.conejo@gmail.com', 'M', '1995-11-04', 'Isidro');
INSERT INTO Persona VALUES ('560546875', 'Sonia', 'Stephens', 'Slon', 'sonia.stephens@gmail.com', 'F', '1986-03-09', 'San José');
INSERT INTO Persona VALUES ('200164645', 'Renata', 'Vasquez', 'Pineda', 'renata.vasquez@gmail.com', 'F', '1989-06-29', 'Guápiles');
INSERT INTO Persona VALUES ('203135498', 'María', 'Jiménez', 'Chaves', 'maria.jimenez@gmail.com', 'F', '1990-12-16', 'Puerto Viejo');


-- Inserts Vendedores
INSERT INTO Vendedor VALUES ('403165495', 500000, 20330);
INSERT INTO Vendedor VALUES ('106070931', 350000, 62250);
INSERT INTO Vendedor VALUES ('203135498', 450000, 96300);


--Inserts Clientes
INSERT INTO Cliente VALUES ('116390735');
INSERT INTO Cliente VALUES ('560546875');
INSERT INTO Cliente VALUES ('200164645');


--Inserts Teléfonos Personas
INSERT INTO TelefonoP VALUES ('403165495', 87654321);
INSERT INTO TelefonoP VALUES ('116390735', 88776655);
INSERT INTO TelefonoP VALUES ('106070931', 86754213);
INSERT INTO TelefonoP VALUES ('560546875', 75324609);
INSERT INTO TelefonoP VALUES ('200164645', 85964130);
INSERT INTO TelefonoP VALUES ('203135498', 60518479);

--Inserts Sucursales
INSERT INTO Sucursal VALUES ('Ciudad Colón');
INSERT INTO Sucursal VALUES ('Santa Ana');

--Inserts Atendidos
INSERT INTO Atiende VALUES ('403165495', '116390735');
INSERT INTO Atiende VALUES ('106070931', '560546875');
INSERT INTO Atiende VALUES ('203135498', '200164645');


--Inserts Telefonos Sucursales
INSERT INTO TelefonoS VALUES ('Ciudad Colón', 22506458);
INSERT INTO TelefonoS VALUES ('Santa Ana', 22612003);


--Inserts Trabaja_En
INSERT INTO Trabaja_En VALUES ('403165495', 'Ciudad Colón');
INSERT INTO Trabaja_En VALUES ('106070931','Santa Ana');
INSERT INTO Trabaja_En VALUES ('203135498','Santa Ana');


--Inserts Contenedores
INSERT INTO Contenedor VALUES ('2016-03-06', 'Subasta medieval', 'ASOCOLEC');
INSERT INTO Contenedor VALUES ('2016-08-23', 'Compra artículas Segunda Guerra Mundial', 'Yiuseff von Hummels');
INSERT INTO Contenedor VALUES ('2017-01-01', 'Compra exposición de arte antiguo', 'MADC');


--Inserts Categorías
INSERT INTO Categoria VALUES ('Silla medieval');
INSERT INTO Categoria VALUES ('Lámpara clásica');
INSERT INTO Categoria VALUES ('Cuadro del barroco');
INSERT INTO Categoria VALUES ('Armario siglo XVIII');


--Inserts Productos
INSERT INTO Producto VALUES ('Armario siglo XVIII', '2016-03-06', 70000, 2, 'Ciudad Colón');
INSERT INTO Producto VALUES ('Silla medieval', '2016-03-06', 50000, 4, 'Ciudad Colón');
INSERT INTO Producto VALUES ('Lámpara clásica', '2016-08-23', 35000, 2, 'Santa Ana');
INSERT INTO Producto VALUES ('Cuadro del barroco', '2017-01-01', 70000, 6, 'Santa Ana');


--Inserts Compras/Incluye
INSERT INTO Compra VALUES ('2017-06-02 12:40:00', 'Ciudad Colón', '403165495', '116390735');
INSERT INTO Incluye VALUES ('2017-06-02 12:40:00', 'Ciudad Colón', 'Armario siglo XVIII', '2016-03-06', 2, 10, 126000);
INSERT INTO Incluye VALUES ('2017-06-02 12:40:00', 'Ciudad Colón', 'Silla Medieval', '2016-03-06', 2, 10, 90000);


INSERT INTO Compra VALUES ('2017-07-11 15:15:15', 'Santa Ana', '203135498', '200164645');
INSERT INTO Incluye VALUES ('2017-07-11 15:15:15', 'Santa Ana', 'Cuadro del barroco', '2017-01-01', 2, 5, 133000);


INSERT INTO Compra VALUES ('2016-08-23 15:15:15', 'Santa Ana', '203135498', '200164645');
INSERT INTO Incluye VALUES ('2016-08-23 15:15:15', 'Santa Ana', 'Lámpara clásica', '2016-08-23', 1, 0, 35000);
