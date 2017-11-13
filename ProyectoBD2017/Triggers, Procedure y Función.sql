use BD_OutletAntiguedadesColonial;


--------------------------PROCEDURE--------------------------------

drop procedure insertarContenedor

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
go

exec insertarContenedor '2017-08-23' , 'Productos Contemporaneos','FADEC';


-----------------------FUNCTIONS------------------------------

DROP FUNCTION CalculaMontoTotal

go 
create function CalculaMontoTotal
(@desc int, @cant int, @precio int)
returns float
as 
begin
declare @monto float;
select @monto = (@precio * @cant) - ((@precio * @cant) * (cast(@desc as float) / 100))
return @monto 
end
go 


DECLARE @monto float; 
EXEC @monto = CalculaMontoTotal 10, 2, 70000
SELECT @monto as 'Monto'


-------------------TRIGGERS-----------------------


drop trigger RestriccionTelefonoPersona;
drop trigger RestriccionTelefonoSucursal;

/* Trigger telefono persona */

go
create trigger RestriccionTelefonoPersona on TelefonoP
instead of insert  
as
	declare @Cedula char(9),@Telefono varchar(20)
	declare CursorTelefono Cursor for select i.Cedula,i.Telefono
    from inserted i;

	open CursorTelefono

	fetch next from CursorTelefono into @Cedula,@Telefono;

	WHILE @@FETCH_STATUS = 0

	begin

	if((LEN(@Telefono)) > 8)begin
    insert into TelefonoP values (@Cedula,@Telefono) end
	
	else begin
	print 'Error, el teléfono debe tener como mínimo ocho dígitos'
	end

	fetch next from CursorTelefono into @Cedula,@Telefono;

	end
							
	close CursorTelefono
	deallocate CursorTelefono
go

/* Trigger telefono Sucursal */

go
create trigger RestriccionTelefonoSucursal on TelefonoS
instead of insert  
as
	declare @Ubicacion nvarchar(100),@Telefono varchar(20)
	declare CursorTelefonoS Cursor for select i.Ubicacion,i.Telefono
    from inserted i;

	open CursorTelefonoS

	fetch next from CursorTelefonoS into @Ubicacion,@Telefono;

	WHILE @@FETCH_STATUS = 0

	begin

	if((LEN(@Telefono)) > 8)begin
    insert into TelefonoS values (@Ubicacion,@Telefono) end
	
	else begin
	print 'Error, el teléfono debe tener como mínimo ocho dígitos'
	end

	fetch next from CursorTelefonoS into @Ubicacion,@Telefono;

	end
							
	close CursorTelefonoS
	deallocate CursorTelefonoS
go


/*

drop procedure ActualizarInventario
drop trigger RestaInventario 

go 
create procedure ActualizarInventario
@nomProd nvarchar(100), @fecha date, @cant int
as
update Producto
set CantidadInventario = @cant
where 
Nombre = @nomProd and 
Fecha = @fecha 


go
create trigger RestaInventario on Incluye
after insert  
as
begin
	declare @nomProd nvarchar(100), @fecha date, @cant int, @cantInv int, @some int
	select @nomProd = Nombre from inserted
	select @fecha = Fecha from inserted
	select @cant = Cantidad from inserted

	select @cantInv = CantidadInventario from producto 
	where Producto.Nombre = @nomProd and
	Producto.Fecha = @fecha

	set @some = @cantInv - @cant
	
	exec ActualizarInventario @nomProd, @fecha, @some
end
go

*/