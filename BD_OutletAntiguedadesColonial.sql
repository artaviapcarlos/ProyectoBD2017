-- create database BD_OutletAntiguedadesColonial;

use BD_OutletAntiguedadesColonial;

/*DROP TABLE Producto;
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
DROP TABLE Persona;*/


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


