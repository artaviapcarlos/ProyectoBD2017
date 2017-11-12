use BD_OutletAntiguedadesColonial;



--------------------------PROCEDURE--------------------------------




-----------------------FUNCTIONS------------------------------

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



-------------------TRIGGERS-----------------------

go
create trigger RestriccionPrecio on TelefonoP
instead of insert  
as
	declare @Cedula char(9),@Telefono INT
	declare CursorTelefono Cursor for select i.Cedula,i.Telefono
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