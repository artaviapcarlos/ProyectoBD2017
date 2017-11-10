use BD_OutletAntiguedadesColonial;

DROP TABLE Producto;
DROP TABLE Categoria;
DROP TABLE Compra;
DROP TABLE Contenedor;
DROP TABLE TelefonoS;
DROP TABLE TelefonoP;
DROP TABLE Atiende;
DROP TABLE Cliente;
DROP TABLE Trabaja_En;
DROP TABLE Sucursal;
DROP TABLE Vendedor;
DROP TABLE Persona;


CREATE TABLE Persona (
	Cedula char(9) PRIMARY KEY NOT NULL,
	NombreP nvarchar(20) NOT NULL,
	PrimerApellido nvarchar(20) NOT NULL,
	SegundoApellido nvarchar(20) NOT NULL,
	Email nvarchar(60),
	Genero char,
	FechaNacimiento date,
	Direccion nvarchar (100)
)


CREATE TABLE Vendedor (
	Cedula char(9) PRIMARY KEY NOT NULL
	FOREIGN KEY (Cedula) REFERENCES Persona(Cedula),
	Salario decimal(10, 2),
	TotalVendido int,
	Ubicacion nvarchar(100)
)


CREATE TABLE Cliente (
	Cedula char(9) PRIMARY KEY NOT NULL
	FOREIGN KEY (Cedula) REFERENCES Persona(Cedula)
)


CREATE TABLE TelefonoP (
	Cedula char(9) FOREIGN KEY (Cedula) REFERENCES Persona(Cedula),
	Telefono INT
	CONSTRAINT PK_TelefonoP PRIMARY KEY (Cedula, Telefono)
)

 
CREATE TABLE Atiende (
	CedulaV char(9) FOREIGN KEY (CedulaV) REFERENCES Vendedor(Cedula),
	CedulaC char(9) FOREIGN KEY (CedulaC) REFERENCES Cliente(Cedula),
	CONSTRAINT PK_Atiende PRIMARY KEY (CedulaV, CedulaC)
)


CREATE TABLE Sucursal (
	Ubicacion nvarchar(100) PRIMARY KEY NOT NULL
)


CREATE TABLE TelefonoS (
	Ubicacion nvarchar(100) FOREIGN KEY (Ubicacion) REFERENCES Sucursal(Ubicacion),
	Telefono INT
	CONSTRAINT PK_TelefonoS PRIMARY KEY (Ubicacion, Telefono)
)

	
CREATE TABLE Trabaja_En (
	Cedula char(9) FOREIGN KEY (Cedula) REFERENCES Vendedor(Cedula),
	Ubicacion nvarchar(100) FOREIGN KEY (Ubicacion) REFERENCES Sucursal(Ubicacion),
	CONSTRAINT PK_TrabajaEn PRIMARY KEY (Cedula, Ubicacion)
)


CREATE TABLE Compra (
	NumeroCompra int NOT NULL IDENTITY(1,1),
	FechaCompra date NOT NULL,
	Ubicacion nvarchar(100) FOREIGN KEY (Ubicacion) REFERENCES Sucursal(Ubicacion),
	Descuento int DEFAULT 0,
	CedulaV char(9) FOREIGN KEY (CedulaV) REFERENCES Vendedor(Cedula),
	CedulaC char(9) FOREIGN KEY (CedulaC) REFERENCES Cliente(Cedula), 
	CONSTRAINT PK_Compra PRIMARY KEY (NumeroCompra, FechaCompra)
)


CREATE TABLE Categoria (
	Nombre nvarchar(100) PRIMARY KEY NOT NULL
)


CREATE TABLE Contenedor (
	Fecha date PRIMARY KEY NOT NULL,
	Descripcion nvarchar(100),
	NombreProveedor nvarchar(100)
)


CREATE TABLE Producto (
	Fecha date PRIMARY KEY NOT NULL,
	FOREIGN KEY (Fecha) REFERENCES Contenedor(Fecha),
	CantidadInventario int, 
	Precio int,
	NumeroCompra int IDENTITY(1,1),
	FechaCompra date,
	Nombre nvarchar(100) FOREIGN KEY (Nombre) REFERENCES Categoria(Nombre),
	Ubicacion nvarchar(100) FOREIGN KEY (Ubicacion) REFERENCES Sucursal(Ubicacion),
	CONSTRAINT FK_Compra FOREIGN KEY (NumeroCompra, FechaCompra) REFERENCES Compra
)


-- Inserts Personas
INSERT INTO Persona VALUES ('403165495', 'Sergio', 'Chavarria', 'Ortega', 'sergio.chavarria', 'M', '1982-04-23', 'Mingo');
INSERT INTO Persona VALUES ('116390735', 'Jose', 'Artavia', 'Moya', 'jose.artavia', 'M', '1996-04-23', 'Mingo');
INSERT INTO Persona VALUES ('106070931', 'Andrés', 'Conejo', 'Chaves', 'andres.conejo', 'M', '1995-11-04', 'Isidro');
INSERT INTO Persona VALUES ('560546875', 'Sonia', 'Stephens', 'Slon', 'sonia.stephens', 'F', '1986-03-09', 'San José');
INSERT INTO Persona VALUES ('200164645', 'Renata', 'Vasquez', 'Pineda', 'renata.vasquez', 'F', '1989-06-29', 'Guapiles');
INSERT INTO Persona VALUES ('203135498', 'María', 'Jiménez', 'Chaves', 'maria.jimenez', 'F', '1990-12-16', 'Puerto Viejo');

-- Inserts Vendedores
INSERT INTO Vendedor VALUES ('403165495', 500000, 20330, NULL);
INSERT INTO Vendedor VALUES ('106070931', 350000, 62250, NULL);
INSERT INTO Vendedor VALUES ('203135498', 450000, 96300, NULL);


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


--Inserts Atendidos
INSERT INTO Atiende VALUES ('403165495', '116390735');
INSERT INTO Atiende VALUES ('106070931', '560546875');
INSERT INTO Atiende VALUES ('203135498', '200164645');


--Inserts Sucursales
INSERT INTO Sucursal VALUES ('Ciudad Colón');
INSERT INTO Sucursal VALUES ('Santa Ana');


--Inserts Telefonos Sucursales
INSERT INTO TelefonoS VALUES ('Ciudad Colón', 22506458);
INSERT INTO TelefonoS VALUES ('Santa Ana', 22612003);


--Inserts Trabaja_En
INSERT INTO Trabaja_En VALUES ('403165495', 'Ciudad Colón');
INSERT INTO Trabaja_En VALUES ('106070931','Santa Ana');
INSERT INTO Trabaja_En VALUES ('203135498','Santa Ana');


--Inserts Compras
INSERT INTO Compra VALUES ('2017-04-04', 'Ciudad Colón', 0, '403165495', '116390735');
INSERT INTO Compra VALUES ('2017-05-05', 'Santa Ana', 5, '106070931', '560546875');
INSERT INTO Compra VALUES ('2017-06-06', 'Santa Ana', 10, '203135498', '200164645');


--Inserts Categorías
INSERT INTO Categoria VALUES ('Silla medieval');
INSERT INTO Categoria VALUES ('Lámpara clásica');
INSERT INTO Categoria VALUES ('Cuadro del barroco');


--Inserts Contenedores
INSERT INTO Contenedor VALUES ('2016-03-06', 'Subasta medieval', 'ASOCOLEC');
INSERT INTO Contenedor VALUES ('2016-08-23', 'Compra artículas Segunda Guerra Mundial', 'Yiuseff von Hummels');
INSERT INTO Contenedor VALUES ('2017-01-01', 'Compra exposición de arte antiguo', 'MADC');


--Inserts Productos
INSERT INTO Producto VALUES ('2016-03-06', 4, 50000, '2017-04-04', 'Silla medieval', 'Ciudad Colón');
INSERT INTO Producto VALUES ('2016-08-23', 2, 35000, '2017-05-05', 'Lámpara clásica', 'Santa Ana');
INSERT INTO Producto VALUES ('2017-01-01', 6, 70000, '2017-06-06', 'Cuadro del barroco', 'Santa Ana');