CREATE TABLE Vendedor (
	Cedula char(9) PRIMARY KEY NOT NULL
	FOREIGN KEY (Cedula) REFERENCES Persona(Cedula) ON DELETE NO ACTION,
	Salario decimal(10, 2),
	TotalVendido int,
	Ubicacion nvarchar(100)
)


CREATE TABLE Cliente (
	Cedula char(9) PRIMARY KEY NOT NULL
	FOREIGN KEY (Cedula) REFERENCES Persona(Cedula) ON DELETE NO ACTION
)

CREATE TABLE TelefonoS (
	Ubicacion nvarchar(100) FOREIGN KEY (Ubicacion) REFERENCES Sucursal(Ubicacion) ON DELETE CASCADE,
	Telefono INT
	CONSTRAINT PK_TelefonoS PRIMARY KEY (Ubicacion, Telefono)
)

	
CREATE TABLE Trabaja_En (
	Cedula char(9) FOREIGN KEY (Cedula) REFERENCES Vendedor(Cedula),
	Ubicacion nvarchar(100) FOREIGN KEY (Ubicacion) REFERENCES Sucursal(Ubicacion) ON DELETE CASCADE,
	CONSTRAINT PK_TrabajaEn PRIMARY KEY (Cedula, Ubicacion)
)


CREATE TABLE Compra (
	NumeroCompra int NOT NULL IDENTITY(1,1),
	FechaCompra date NOT NULL,
	Ubicacion nvarchar(100) FOREIGN KEY (Ubicacion) REFERENCES Sucursal(Ubicacion) ON DELETE CASCADE,
	Descuento int DEFAULT 0,
	CedulaV char(9) FOREIGN KEY (CedulaV) REFERENCES Vendedor(Cedula),
	CedulaC char(9) FOREIGN KEY (CedulaC) REFERENCES Cliente(Cedula), 
	CONSTRAINT PK_Compra PRIMARY KEY (NumeroCompra, FechaCompra)
)

CREATE TABLE Producto (
	Fecha date PRIMARY KEY NOT NULL,
	FOREIGN KEY (Fecha) REFERENCES Contenedor(Fecha),
	CantidadInventario int, 
	Precio int,
	NumeroCompra int IDENTITY(1,1),
	FechaCompra date,
	Nombre nvarchar(100) FOREIGN KEY (Nombre) REFERENCES Categoria(Nombre),
	Ubicacion nvarchar(100) FOREIGN KEY (Ubicacion) REFERENCES Sucursal(Ubicacion) ON DELETE CASCADE,
	CONSTRAINT FK_Compra FOREIGN KEY (NumeroCompra, FechaCompra) REFERENCES Compra
)


