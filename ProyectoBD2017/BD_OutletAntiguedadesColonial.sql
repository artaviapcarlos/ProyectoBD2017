use BD_OutletAntiguedadesColonial;

/*
DROP TABLE Incluye;
DROP TABLE Compra;
DROP TABLE Producto;
DROP TABLE Categoria;
DROP TABLE Contenedor;
DROP TABLE TelefonoS;
DROP TABLE TelefonoP;
DROP TABLE Atiende;
DROP TABLE Cliente;
DROP TABLE Trabaja_En;
DROP TABLE Sucursal;
DROP TABLE Vendedor;
DROP TABLE Persona;
*/

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
ALTER TABLE Persona ADD Constraint CK_Genero check (Genero = 'F' OR Genero = 'M');


CREATE TABLE Vendedor (
	Cedula char(9) PRIMARY KEY NOT NULL
	FOREIGN KEY (Cedula) REFERENCES Persona(Cedula) ON DELETE NO ACTION,
	Salario decimal(10, 2) NOT NULL,
	TotalVendido float
)
ALTER TABLE Vendedor ADD Constraint CK_Salario_Mayor_A_100000 check (Salario >= 100000 and Salario <= 500000);


CREATE TABLE Sucursal (
	Ubicacion nvarchar(100) PRIMARY KEY NOT NULL,
	NombreS nvarchar(20) NOT NULL 
)


CREATE TABLE Cliente (
	Cedula char(9) PRIMARY KEY NOT NULL
	FOREIGN KEY (Cedula) REFERENCES Persona(Cedula) ON DELETE NO ACTION
)


CREATE TABLE TelefonoP (
	Cedula char(9) NOT NULL FOREIGN KEY (Cedula) REFERENCES Persona(Cedula),
	Telefono varchar(20),
	CONSTRAINT PK_TelefonoP PRIMARY KEY (Cedula, Telefono)
)

 
CREATE TABLE Atiende (
	CedulaV char(9) NOT NULL FOREIGN KEY (CedulaV) REFERENCES Vendedor(Cedula),
	CedulaC char(9) NOT NULL FOREIGN KEY (CedulaC) REFERENCES Cliente(Cedula),
	CONSTRAINT PK_Atiende PRIMARY KEY (CedulaV, CedulaC)
)


CREATE TABLE TelefonoS (
	Ubicacion nvarchar(100) NOT NULL FOREIGN KEY (Ubicacion) REFERENCES Sucursal(Ubicacion) ON DELETE CASCADE,
	Telefono varchar(20) NOT NULL
	CONSTRAINT PK_TelefonoS PRIMARY KEY (Ubicacion, Telefono)
)

	
CREATE TABLE Trabaja_En (
	Cedula char(9) FOREIGN KEY (Cedula) REFERENCES Vendedor(Cedula),
	Ubicacion nvarchar(100) FOREIGN KEY (Ubicacion) REFERENCES Sucursal(Ubicacion) ON DELETE CASCADE,
	CONSTRAINT PK_TrabajaEn PRIMARY KEY (Cedula, Ubicacion)
)


CREATE TABLE Categoria (
	Nombre nvarchar(100) PRIMARY KEY NOT NULL
)


CREATE TABLE Contenedor (
	Fecha date PRIMARY KEY NOT NULL,
	Precio float,
	Descripcion nvarchar(100),
	NombreProveedor nvarchar(100) 
)


CREATE TABLE Producto (
	Nombre nvarchar(100) NOT NULL FOREIGN KEY (Nombre) REFERENCES Categoria(Nombre),
	Fecha date NOT NULL FOREIGN KEY (Fecha) REFERENCES Contenedor(Fecha) on update cascade,
	Precio float NOT NULL,
	CantidadInventario int NOT NULL, 
	Ubicacion nvarchar(100) NOT NULL FOREIGN KEY (Ubicacion) REFERENCES Sucursal(Ubicacion) ON DELETE CASCADE
	CONSTRAINT PK_Producto PRIMARY KEY (Nombre, Fecha)
)
ALTER TABLE Producto ADD Constraint CK_CantidadInventario check (CantidadInventario > 0);


CREATE TABLE Compra (
	NumeroCompra int NOT NULL IDENTITY(1,1),
	FechaCompra smalldatetime NOT NULL,
	Ubicacion nvarchar(100) NOT NULL FOREIGN KEY (Ubicacion) REFERENCES Sucursal(Ubicacion) ON DELETE CASCADE,
	CedulaV char(9) NOT NULL FOREIGN KEY (CedulaV) REFERENCES Vendedor(Cedula),
	CedulaC char(9) NOT NULL FOREIGN KEY (CedulaC) REFERENCES Cliente(Cedula),
	CONSTRAINT PK_Compra PRIMARY KEY (FechaCompra, Ubicacion),
)


CREATE TABLE Incluye (
	FechaCompra smalldatetime NOT NULL,
	Ubicacion nvarchar(100) NOT NULL,
	Nombre nvarchar(100) NOT NULL,
	Fecha date NOT NULL,
	Cantidad int NOT NULL,
	Descuento int DEFAULT 0,
	MontoTotal int NOT NULL
	CONSTRAINT PK_Incluye PRIMARY KEY (FechaCompra, Ubicacion, Nombre, Fecha)
)
ALTER TABLE Incluye ADD 
CONSTRAINT FK_Compra FOREIGN KEY (FechaCompra, Ubicacion) REFERENCES Compra(FechaCompra, Ubicacion),
CONSTRAINT FK_Producto FOREIGN KEY (Nombre, Fecha) REFERENCES Producto(Nombre, Fecha) 
