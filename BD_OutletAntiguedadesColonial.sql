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
ALTER TABLE Vendedor ADD Constraint CK_Salario_Mayor_A_100000 check ( Salario <= 400000 and Salario >= 100000);


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

--------------------PROCEDURE----------------------------------

go
create procedure insertarContenedor(

@Fecha date,
@Descripcion varchar(100),
@NombreProveedor varchar(100)
)
as
insert into Contenedor
(Fecha,Descripcion,NombreProveedor)
values
(@Fecha,@Descripcion,@NombreProveedor);


exec insertarContenedor '23-08-2017' , 'Productos Contemporaneos','FADEC';


----------------TRIGGER-----------------------

go
create trigger RestriccionPrecio on TelefonoP
instead of insert  
as

	declare @Cedula char(9),@Telefono INT
	declare CursorTelefono Cursor for select  i.Cedula,i.Telefono
    from inserted i;

	open CursorTelefono

	fetch next from CursorTelefono into @Cedula,@Telefono;

	WHILE @@FETCH_STATUS = 0

	begin

	if((LEN(@Telefono)) = 8 )begin
    insert into TelefonoP values (@Cedula,@Telefono) end
	--('2017-01-01', 6, 70000, '2017-06-06', 'Cuadro del barroco', 'Santa Ana');
	

	else begin
	print 'Error, el teléfono debe ser de ocho dígitos'
	end

	fetch next from CursorTelefono into @Cedula,@Telefono;

	end
							
	close CursorTelefono
	deallocate CursorTelefono
go
